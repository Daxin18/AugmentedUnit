class_name state_screaming
extends State

@export var falling_state: State
@export var dying_state: State

func enter() -> void:
	parent.animations.play(animation_name)
	parent.logic.skill_reset_on_scream()

func exit() -> void:
	pass

func process_physics(delta: float) -> State:
	parent.velocity = Vector2.ZERO
	if not parent.logic.is_screaming():
		return falling_state
	return null
