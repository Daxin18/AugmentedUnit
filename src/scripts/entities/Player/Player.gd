class_name Player
extends Actor

@onready var animations = $Sprite/AnimationPlayer
@onready var audio_player = $AudioPlayer

@onready var state_machine = $state_machine
@onready var state_logic = $StateLogicHolder
@onready var interaction_logic = $InteractionLogicHolder

func _ready() -> void:
	state_machine.init(self)
	state_logic.init(self)
	interaction_logic.init(self)
	state_logic.set_spawnpoint(position)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
