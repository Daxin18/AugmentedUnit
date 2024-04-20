#
# Separate script for logic instroduced so that the main player script
# stays small and easy to read...
# this one is not, may want to reorganize it later
#

class_name PlayerCommonStateLogic
extends Node

var parent: Player

@export var max_remaining_jumps: = 1
@export var max_remaining_dashes: = 0
@export var max_remaining_screams: = 0 #not expected to be changed

# these below are exported only for debugging
@export var remaining_jumps: = 0
@export var remaining_dashes: = 0
@export var remaining_screams: = 0
var has_recently_jumped: = false
var has_recently_dashed: = false
var has_recently_screamed: = false
var is_in_dash: = false
var is_in_scream: = false
var progression_manager: ProgressionManager

var spawnpoint: = Vector2.ZERO

func init(player: Player) -> void:
	parent = player
	progression_manager = get_tree().get_root().get_node("Main").find_child("ProgressionManager")

# ===========================
# 		Universal
# ===========================

func reset_skills() -> void:
	remaining_jumps = max_remaining_jumps
	remaining_dashes = max_remaining_dashes
	remaining_screams = max_remaining_screams

func apply_gravity() -> void:
	parent.velocity.y += Constants.gravity_strength

# ===========================
# 	Horizontal movement
# ===========================
func handle_horizontal_movement() -> bool:
	var direction = Input.get_axis("move_left", "move_right")
	parent.velocity.x = direction * Constants.move_speed
	
	if direction != 0:
		parent._set_facing_left(direction < 0)
		return true
	else:
		parent.velocity.x = 0
	return false

# ===========================
# 			Jumping
# ===========================

func can_jump() -> bool:
	return (remaining_jumps > 0) #and not has_recently_jumped

func jump() -> void:
	parent.velocity.y = -Constants.jump_strength
	start_jump_cooldown()

func handle_jump() -> bool:
	if Input.is_action_just_pressed("jump") and can_jump():
		remaining_jumps -= 1
		#jump() #handle this on entering state, not here!
		return true
	return false

func apply_coyote_timing() -> void:
	# ensure player is falling out of platform and is not in the apex of a jump
	if remaining_jumps == max_remaining_jumps:
		await get_tree().create_timer(Constants.coyote_timing).timeout
		# ensure player didn't jump during coyote_timing
		if remaining_jumps == max_remaining_jumps:
			# remove one jump
			# (if a player unlocked double-jump they can still use it)
			remaining_jumps -= 1

# ensures small delay between jumps
# so that the player doesn't accidentally use both of them when mashing space
func start_jump_cooldown() -> void:
	has_recently_jumped = true
	await get_tree().create_timer(Constants.skill_spam_cooldown).timeout
	has_recently_jumped = false

# ===========================
# 			Dashing
# ===========================
func can_dash() -> bool:
	return remaining_dashes > 0

func dash() -> void:
	parent.velocity = Vector2(Constants.dash_strength, 0) * get_dash_direction_factor()
	start_dash_cooldown()
	start_dash_duration()

func get_dash_direction_factor() -> Vector2:
	var direction_factor: = Vector2.ZERO
	if parent.is_facing_left:
		direction_factor.x = -1
	else:
		direction_factor.x = 1
	return direction_factor

func start_dash_cooldown() -> void:
	has_recently_dashed = true
	await get_tree().create_timer(Constants.skill_spam_cooldown).timeout
	has_recently_dashed = false

func start_dash_duration() -> void:
	is_in_dash = true
	await get_tree().create_timer(Constants.dash_duration).timeout
	is_in_dash = false
	
func handle_dash() -> bool:
	if Input.is_action_just_pressed("dash") and can_dash():
		remaining_dashes -= 1
		#dash()
		return true
	return false

func is_dashing() -> bool:
	return is_in_dash

# ========================
# 		Screaming
# ========================

func can_scream() -> bool:
	return (remaining_screams > 0)

func scream() -> void:
	parent.velocity = Vector2.ZERO
	start_scream_duration()
	start_scream_cooldown()

func handle_scream() -> bool:
	if Input.is_action_just_pressed("scream") and can_scream():
		remaining_screams -= 1
		#scream()
		return true
	return false

func start_scream_duration() -> void:
	is_in_scream = true
	await get_tree().create_timer(Constants.scream_duration).timeout
	is_in_scream = false

func start_scream_cooldown() -> void:
	has_recently_screamed = true
	await get_tree().create_timer(Constants.skill_spam_cooldown).timeout
	has_recently_screamed = false

func skill_reset_on_scream() -> void:
	remaining_jumps = max_remaining_jumps
	remaining_dashes = max_remaining_dashes

func is_screaming() -> bool:
	return is_in_scream

# ============================
# 		Modifications
# ============================

# may need some better tracking than this
func unlock_modification(mod: Modifications.Mod) -> void:
	match mod:
		Modifications.Mod.double_jump:
			max_remaining_jumps = 2
			remaining_jumps = max_remaining_jumps
		Modifications.Mod.dash:
			max_remaining_dashes = 1
			remaining_dashes = max_remaining_dashes
		Modifications.Mod.scream:
			max_remaining_screams = 1
			remaining_screams = max_remaining_screams
	progression_manager.record_mod_pickup(mod)

# ============================
# 		Dying/Respawning
# ============================

func set_spawnpoint(new_spawnpoint: Vector2) -> void:
	spawnpoint = new_spawnpoint
	var allNodes = get_tree().get_root().get_node("Main").find_child("LevelManager").reset_spawnpoint_textures()

func respawn() -> void:
	parent.position = spawnpoint
	lethal_collisions = []

# temp implementation for PoC
# I would ideally ddo this using signals from other entities
# but let's stick with that
func check_for_death() -> bool:
	if not lethal_collisions.is_empty():
		lethal_collisions = []
		return true
	return false

# declaring variables here as this is a temp implementation
var stay_dead_for_seconds: = 3
var is_dying: = false
var lethal_collisions: = []

func die() -> void:
	parent.audio_manager.play_sfx(PlayerAudioManager.Sounds.Death)
	var bodypart_manager = get_tree().get_root().get_node("Main").find_child("BodypartManager")
	bodypart_manager.spawn_parts(parent.global_position)
	is_dying = true
	await get_tree().create_timer(stay_dead_for_seconds).timeout
	is_dying = false

func can_respawn() -> bool:
	return not is_dying

func _on_hitbox_body_entered(body):
	if body is Lethal:
		lethal_collisions.append(body)
