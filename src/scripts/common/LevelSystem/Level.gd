class_name Level
extends Node

@export var default_spawn: Hardpoint

var hardpoints: Array[Hardpoint] = []

func _ready():
	set_hardpoints()
	for child in get_children():
		if child is Door:
			child.init()

func set_hardpoints() -> void:
	for child in get_children():
		if child is Door:
			hardpoints.append(child.hardpoint)
		if child is Hardpoint:
			hardpoints.append(child)

func reset_spawnpoint_textures() -> void:
	var spawnpoints = $Respawnpoints
	var children = spawnpoints.get_children(true)
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
