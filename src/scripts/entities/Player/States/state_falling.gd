class_name state_falling
extends State

@export var dashing_state: State
@export var screaming_state: State
@export var jumping_state: State
@export var dying_state: State
@export var idle_state: State
@export var moving_state: State

func enter() -> void:
	parent.animations.play(animation_name)
	parent.state_logic.apply_coyote_timing()

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	parent.state_logic.handle_horizontal_movement()
	if parent.state_logic.handle_scream():
		return screaming_state
	if parent.state_logic.handle_dash():
		return dashing_state
	if parent.state_logic.handle_jump():
		return jumping_state
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	parent.state_logic.apply_gravity()
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if parent.velocity.x == 0:
			return idle_state
		else:
			return moving_state
	return null
