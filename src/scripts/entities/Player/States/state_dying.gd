class_name state_dying
extends State

@export var falling_state: State

func enter() -> void:
	parent.animations.play(animation_name)
	parent.velocity = Vector2.ZERO
	parent.state_logic.die()

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if parent.state_logic.can_respawn():
		parent.state_logic.respawn()
		return falling_state
	return null
