class_name Level
extends Node

@export var default_spawn: Hardpoint

var hardpoints: Array[Hardpoint] = []

func _ready():
	set_hardpoints()

func set_hardpoints() -> void:
	var doors = $Doors
	if doors:
		var children = doors.get_children()
		for child in children:
			if child is Door:
				hardpoints.append(child.hardpoint)

func reset_spawnpoint_textures() -> void:
	var spawnpoints = $Respawnpoints
	if spawnpoints:
		var children = spawnpoints.get_children()
		for child in children:
			if child is RespawnStation:
				child.set_current_spawnpoint(false)

func spawn_player(spawnpoint_id: Hardpoints.Id, player: Player) -> void:
	for point in hardpoints:
		if point.id == spawnpoint_id:
			point.spawn(player)
			return
	print("No spawnpoint found, spawning on default")
	default_spawn.spawn(player)
