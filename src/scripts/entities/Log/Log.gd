class_name Log
extends Interactable

@export var id: Logs.LogId

func interact(entity: Actor) -> void:
	if entity is Player:
		entity.interaction_logic.play_log(id)
		queue_free() # once the log is collected, we don't need it
