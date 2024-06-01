class_name Player
extends Actor

@onready var animations = $Sprite/AnimationPlayer
@onready var log_player = $LogPlayer

@onready var state_machine = $state_machine
@onready var state_logic = $StateLogicHolder
@onready var interaction_logic = $InteractionLogicHolder
@onready var audio_manager = $AudioManager
@onready var hint = $Hint

# temp - remove once options implemented
@export var logs_autoplay: bool

func _ready() -> void:
	state_machine.init(self)
	state_logic.init(self)
	interaction_logic.init(self)
	state_logic.set_spawnpoint(position)
	Options.autoplay_logs = logs_autoplay

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
