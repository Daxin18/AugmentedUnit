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
var level_manager: LevelManager

var spawnpoint: = Vector2.ZERO

func init(player: Player) -> void:
	parent = player
	progression_manager = get_tree().get_root().get_node("Main").find_child("ProgressionManager")
	level_manager = get_tree().get_root().get_node("Main").find_child("LevelManager")
	init_hud

func _process(delta):
	if progression_manager.is_endgame():
		update_timer()

# ===========================
# 		Universal
# ===========================

func reset_skills() -> void:
	remaining_jumps = max_remaining_jumps
	remaining_dashes = max_remaining_dashes
	remaining_screams = max_remaining_screams
	toggle_mod_hud(Modifications.Mod.dash, true)
	toggle_mod_hud(Modifications.Mod.double_jump, true)
	toggle_mod_hud(Modifications.Mod.scream, true)

func apply_gravity() -> void:
	parent.velocity.y += Constants.gravity_strength

# ===========================
# 	Horizontal movement
# ===========================
var confusion_moifier: = 1

func handle_horizontal_movement() -> bool:
	var direction = Input.get_axis("move_left", "move_right")
	parent.velocity.x = direction * Constants.move_speed * confusion_moifier
	
	if direction != 0:
		parent._set_facing_left(direction < 0)
		return true
	else:
		parent.velocity.x = 0
	return false

func apply_confusion(time: float) -> void:
	confusion_moifier = -1
	await get_tree().create_timer(time).timeout
	confusion_moifier = 1

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
		if remaining_jumps == 0:
			toggle_mod_hud(Modifications.Mod.double_jump, false)
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
		toggle_mod_hud(Modifications.Mod.dash, false)
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
		toggle_mod_hud(Modifications.Mod.scream, false)
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
	toggle_mod_hud(Modifications.Mod.dash, true)
	toggle_mod_hud(Modifications.Mod.double_jump, true)

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
	enable_mod_hud(mod)
	progression_manager.record_mod_pickup(mod)

# ============================
# 		Trampoline
# ============================

# dirty way of doing things, but I'm tired
@onready var TrampolineState = $"../state_machine/Trampolined"

var movement_locked: = false

func trampoline_player(force: Vector2, movement_lock_duration: float) -> void:
	movement_locked = true
	parent.state_machine.change_state(TrampolineState)
	parent.velocity = force
	await get_tree().create_timer(movement_lock_duration).timeout
	movement_locked = false

func trampoline_can_move() -> bool:
	return not movement_locked

# ============================
# 			Menu
# ============================
@onready var BlockedState = $"../state_machine/BLOCKED"
@onready var FallingState = $"../state_machine/Falling"

func block_player() -> void:
	parent.state_machine.change_state(BlockedState)

func unlock_player() -> void:
	parent.state_machine.change_state(FallingState)

# ============================
# 		Dying/Respawning
# ============================

func set_spawnpoint(new_spawnpoint: Vector2) -> void:
	spawnpoint = new_spawnpoint
	level_manager.reset_spawnpoint_textures()
	set_level_name_hud()

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

# ============================
# 			HUD
# ============================

@onready var dash_hud = $"../CanvasLayer/HUD/Skills/Dash"
@onready var jump_hud = $"../CanvasLayer/HUD/Skills/DJump"
@onready var scream_hud = $"../CanvasLayer/HUD/Skills/Scream"
@onready var level_name_hud = $"../CanvasLayer/HUD/LevelName"
@onready var timer_hud = $"../CanvasLayer/HUD/Timer"

func init_hud():
	for mod in progression_manager.get_collected_mods():
		enable_mod_hud(mod)
	set_level_name_hud()

func enable_mod_hud(mod: Modifications.Mod) -> void:
	match mod:
		Modifications.Mod.dash:
			dash_hud.visible = true
		Modifications.Mod.double_jump:
			jump_hud.visible = true
		Modifications.Mod.scream:
			scream_hud.visible = true

func toggle_mod_hud(mod: Modifications.Mod, ready: bool) -> void:
	var icon
	match mod:
		Modifications.Mod.dash:
			icon = dash_hud
		Modifications.Mod.double_jump:
			icon = jump_hud
		Modifications.Mod.scream:
			icon = scream_hud
	if icon:
		if ready:
			icon.modulate = Color8(255,255,255,255)
		else:
			icon.modulate = Color8(255,255,255,50)

func set_level_name_hud() -> void:
	var current_level = level_manager.current_level
	if current_level:
		var text = Levels.get_level_name(current_level.level_id)
		level_name_hud.text = text
		for child in level_name_hud.get_children():
			child.text = text

func update_timer() -> void:
	timer_hud.visible = true
	var timer = progression_manager.endgame_timer
	var min: int = timer / 60
	var sec: int = int(timer) % 60
	var text = str(min) + ":"
	if sec < 10:
		text = text + "0" + str(sec)
	else:
		text = text + str(sec)
	timer_hud.text = text
	for child in timer_hud.get_children():
			child.text = text

# ============================
# 			Endgame
# ============================

func start_endgame(endgame_music: AudioStream) -> void:
	progression_manager.start_endgame(endgame_music)
	update_timer()

# ============================
# 			Signals
# ============================

func _on_hitbox_body_entered(body):
	if body is Lethal:
		lethal_collisions.append(body)

func _on_hitbox_area_entered(area):
	if area is Lethal:
		lethal_collisions.append(area)
