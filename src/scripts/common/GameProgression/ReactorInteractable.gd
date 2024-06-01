class_name ReactorInteractable
extends Interactable

@onready var progression_manager: ProgressionManager = get_tree().get_root().get_node("Main").find_child("ProgressionManager")

func interact(body: Actor) -> void:
	if body is Player:
		progression_manager.enable_power()
