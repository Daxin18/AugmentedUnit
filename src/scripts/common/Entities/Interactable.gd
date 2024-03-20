class_name Interactable
extends Area2D

func _ready():
	# all interactables should be on layer 2
	set_collision_layer_value(2, true)

func interact(entity: Actor) -> void:
	pass

# TODO: add some sort of indication that a player can interact with an item
