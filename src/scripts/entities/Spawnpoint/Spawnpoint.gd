class_name RespawnStation
extends Interactable

@onready var hardpoint: Node2D = $Hardpoint

func interact(entity: Actor) -> void:
	if entity is Player:
		# this might need adjusting
		# it feels weird to call state_logic from Interactable
		entity.state_logic.set_spawnpoint(hardpoint.global_position)
