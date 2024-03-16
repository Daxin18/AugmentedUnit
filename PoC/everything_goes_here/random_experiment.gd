extends Node2D

func _ready():
	# this should be in some global setup
	# prevents jittering when moving pixel art too fast
	Engine.max_fps = 60
