class_name state_moving
extends State

@export var jumping_state: State
@export var falling_state: State
@export var dashing_state: State
@export var screaming_state: State
@export var idle_state: State
@export var dying_state: State

func enter() -> void:
	parent.sprite.flip_h = parent.is_facing_left
	parent.animations.play(animation_name)
	parent.state_logic.reset_skills()

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	if parent.state_logic.handle_scream():
		return screaming_state
	if parent.state_logic.handle_dash():
		return dashing_state
	if parent.state_logic.handle_jump():
		return jumping_state
	if parent.state_logic.handle_horizontal_movement():
		return null
	return idle_state

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	if parent.state_logic.check_for_death():
		return dying_state
	if not parent.is_on_floor():
		return falling_state
	if parent.velocity == Vector2.ZERO:
		return idle_state
	return null
