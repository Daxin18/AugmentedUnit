class_name Player
extends Actor

@onready var animations = $Sprite/AnimationPlayer
@onready var state_machine = $state_machine
@onready var logic = $CommonStateLogicHolder

func _ready() -> void:
	state_machine.init(self)
	logic.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
