class_name Interactable
extends Area2D

# this is overwritten for doors and logs as they would break if interacted with
@export var log_blocks_interaction: = false

func _ready():
	# all interactables should be on layer 2
	set_collision_layer_value(2, true)

func interact(entity: Actor) -> void:
	pass

