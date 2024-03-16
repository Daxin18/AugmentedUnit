class_name state_dashing
extends State

@export var falling_state: State
@export var dying_state: State
@export var screaming_state: State

func enter() -> void:
	parent.animations.play(animation_name)
	parent.state_logic.dash()

func exit() -> void:
	parent.velocity = Vector2.ZERO # this prevents sliding bug

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	if parent.state_logic.handle_scream():
		return screaming_state
	if not parent.state_logic.is_dashing():
		return falling_state
	return null
