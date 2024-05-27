class_name Log
extends Interactable

@export var id: Logs.LogId

func _ready():
	log_blocks_interaction = false

func interact(entity: Actor) -> void:
	if entity is Player:
		if Options._do_logs_play():
			entity.interaction_logic.play_log(id)
		else:
			entity.interaction_logic.collect_log(id)
		queue_free() # once the log is collected, we don't need it
