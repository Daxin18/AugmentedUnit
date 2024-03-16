class_name state_dashing
extends State

@export var falling_state: State
@export var dying_state: State
@export var screaming_state: State

func enter() -> void:
	parent.animations.play(animation_name)
	#parent.velocity = Vector2(Constants.dash_strength, 0)

func exit() -> void:
	pass

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	if parent.logic.handle_scream():
		return screaming_state
	if not parent.logic.is_dashing():
		return falling_state
	return null
