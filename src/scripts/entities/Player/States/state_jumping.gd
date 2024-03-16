class_name state_jumping
extends State

@export var falling_state: State
@export var dashing_state: State
@export var screaming_state: State
@export var dying_state: State

func enter() -> void:
	parent.animations.play(animation_name)
	parent.state_logic.jump()

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	parent.state_logic.handle_horizontal_movement()
	if parent.state_logic.handle_scream():
		return screaming_state
	if parent.state_logic.handle_dash():
		return dashing_state
	if parent.state_logic.handle_jump():
		return self #aka re-enter jumping state
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	parent.state_logic.apply_gravity()
	if parent.velocity.y > 0:
		return falling_state
	return null
