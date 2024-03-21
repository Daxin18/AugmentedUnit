class_name Exit
extends Interactable

#	A class representing a passage between sections of the game (levels/scenes)
#
#	A simplistic version for the PoC, might leave some ideas for variables and/or functions

# @export var next_stage: Stage #?

func interact(entity: Actor) -> void:
	get_tree().quit()
