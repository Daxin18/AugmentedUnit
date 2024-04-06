class_name RespawnStation
extends Interactable

@onready var hardpoint: Node2D = $Hardpoint

func interact(entity: Actor) -> void:
	if entity is Player:
		entity.state_logic.set_spawnpoint(hardpoint.global_position)
