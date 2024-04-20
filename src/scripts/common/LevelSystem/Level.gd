class_name Level
extends Node

@export var default_spawn: Hardpoint

var hardpoints: Array[Hardpoint] = []

func _ready():
	set_hardpoints()
	clear_collected()
	init_level_mechanics()

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

func clear_collected() -> void:
	clear_logs()
	clear_mods()

func clear_logs() -> void:
	var progression_manager: ProgressionManager = get_tree().get_root().get_node("Main").find_child("ProgressionManager")
	var logs_node = find_child("Logs")
	if logs_node: # ugly, but we do not have huge numbers here
		for log: Log in logs_node.get_children():
			if log.id in progression_manager.get_collected_logs():
				log.queue_free()

func clear_mods() -> void:
	var progression_manager: ProgressionManager = get_tree().get_root().get_node("Main").find_child("ProgressionManager")
	var mods_node = find_child("Mods")
	if mods_node:
		for mod: Modification in mods_node.get_children():
			if mod.mod in progression_manager.get_collected_mods():
				mod.queue_free()

func init_level_mechanics() -> void:
	pass
