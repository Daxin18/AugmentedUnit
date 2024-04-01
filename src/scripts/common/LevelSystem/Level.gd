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

# override it
func spawn_player(spawnpoint_id: Hardpoints.Id, player: Player) -> void:
	for point in hardpoints:
		if point.id == spawnpoint_id:
			point.spawn(player)
			return
	# no spawnpoint found - spawning player on the default one
	default_spawn.spawn(player)
