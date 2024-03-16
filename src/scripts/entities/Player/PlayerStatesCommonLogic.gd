#
# Separate script for logic instroduced so that the main player script
# stays small and easy to read...
# this one is not, may want to organize it later
#

class_name PlayerStatesCommonLogic
extends Node

var parent: Player

@export var max_remaining_jumps: = 2
@export var max_remaining_dashes: = 1
@export var max_remaining_screams: = 1 #not expected to be changed

#these below are exported only for debugging
@export var remaining_jumps: = 1
@export var remaining_dashes: = 1
@export var remaining_screams: = 1
var has_recently_jumped: = false
var has_recently_dashed: = false
var has_recently_screamed: = false
var is_in_dash: = false
var is_in_scream: = false

func init(player: Player) -> void:
	parent = player

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
	if Input.is_action_pressed("move_left"):
		parent.velocity.x = - Constants.move_speed
		parent._set_facing_left(true)
		return true
	elif Input.is_action_pressed("move_right"):
		parent.velocity.x = Constants.move_speed
		parent._set_facing_left(false)
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
		jump()
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
		dash()
		return true
	return false

func is_dashing() -> bool:
	return is_in_dash

# ========================
# 		Screaming
# ========================

func can_scream() -> bool:
	return (remaining_screams > 0) #and not has_recently_jumped

func scream() -> void:
	parent.velocity = Vector2.ZERO
	start_scream_duration()
	start_scream_cooldown()

func handle_scream() -> bool:
	if Input.is_action_just_pressed("scream") and can_scream():
		remaining_screams -= 1
		scream()
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
