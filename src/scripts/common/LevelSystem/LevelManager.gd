class_name LevelManager
extends Node

@export_file("*.tscn") var initial_level: String
@export var player: Player

var current_level: Level

func _ready():
	current_level = load(initial_level).instantiate()
	add_child(current_level)
	current_level.spawn_player(Hardpoints.Id.Default_Id, player)

func change_level(new_level: String, hardpoint_id: Hardpoints.Id) -> void:
	remove_child(current_level)
	current_level = load(new_level).instantiate()
	add_child(current_level)
	current_level.spawn_player(hardpoint_id, player)

func reset_spawnpoint_textures() -> void:
	var level: Level = get_child(0)
	if level:
		level.reset_spawnpoint_textures()
