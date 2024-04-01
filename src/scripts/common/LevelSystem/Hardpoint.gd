class_name Hardpoint
extends Node2D

@export var id: Hardpoints.Id

func set_id(new_id: Hardpoints.Id) -> void:
	self.id = new_id

func spawn(player: Player) -> void:
	player.global_position = self.global_position #tp player
	player.state_logic.set_spawnpoint(self.global_position) #set player spawnpoint
	player.state_machine.init(player) # reset state so player doesn't float
