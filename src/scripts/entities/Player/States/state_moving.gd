class_name state_moving
extends State

@export var jumping_state: State
@export var falling_state: State
@export var dashing_state: State
@export var screaming_state: State
@export var idle_state: State
@export var dying_state: State

func enter() -> void:
	parent.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if not parent.is_on_floor():
		return falling_state
	return null
