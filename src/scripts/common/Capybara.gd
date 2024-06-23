class_name Capybara
extends Interactable

@onready var progression_manager: ProgressionManager = get_tree().get_root().get_node("Main").find_child("ProgressionManager")

func interact(entity: Actor) -> void:
	progression_manager.CAPYBARA()
