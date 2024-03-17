class_name Modification
extends Interactable

@export var mod: Modifications.Mod

func interact(entity: Actor) -> void:
	if entity is Player:
		entity.state_logic.unlock_modification(mod)
		queue_free()
