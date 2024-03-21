class_name state_screaming
extends State

@export var falling_state: State
@export var dying_state: State

func enter() -> void:
	parent.animations.play(animation_name)
	parent.state_logic.scream()
	parent.state_logic.skill_reset_on_scream()

func exit() -> void:
	pass

func process_physics(delta: float) -> State:
	parent.velocity = Vector2.ZERO
	if not parent.state_logic.is_screaming():
		return falling_state
	return null
