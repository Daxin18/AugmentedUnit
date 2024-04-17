class_name state_idle
extends State

@export var falling_state: State
@export var moving_state: State
@export var jumping_state: State
@export var dashing_state: State
@export var dying_state: State
@export var screaming_state: State

func enter() -> void:
	parent.animations.play(animation_name)
	parent.state_logic.reset_skills()

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	if parent.state_logic.handle_scream():
		return screaming_state
	if parent.state_logic.handle_horizontal_movement():
		return moving_state
	if parent.state_logic.handle_jump():
		return jumping_state
	parent.velocity.x = 0
	return null

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	if parent.state_logic.check_for_death():
		return dying_state
	if not parent.is_on_floor():
		return falling_state
	return null
