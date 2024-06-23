class_name ActivateNuke
extends Interactable


func interact(body: Actor) -> void:
	if body is Player:
		body.state_logic.start_endgame(Levels.jump_and_groove)
		queue_free()
