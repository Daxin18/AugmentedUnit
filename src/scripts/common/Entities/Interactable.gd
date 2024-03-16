class_name Interactable
extends Node2D
# could technically extend StaticBody2D as there are no interactable-moving items planned
# but if we ever add one I don't want to be the one searching for this common script

func interact(entity: Actor) -> void:
	pass
