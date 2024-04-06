class_name MovingPlatform
extends Path2D

@export var is_closed: = true
@export var closed_speed: = 100
@export var open_speed_scale: = 0.5

@onready var path: = $PathFollow2D
@onready var animation: = $AnimationPlayer

func _ready():
	if not is_closed: # open path
		animation.play("move")
		animation.speed_scale = open_speed_scale
		set_process(false)

func _process(delta): # closed path
	path.progress += closed_speed * delta
