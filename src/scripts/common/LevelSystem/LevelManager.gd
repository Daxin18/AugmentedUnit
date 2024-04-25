class_name LevelManager
extends Node

@export var initial_level: Levels.LevelId
@export var player: Player

@onready var fading: = $CanvasLayer/fading

var current_level: Level

func _ready():
	fade_in()
	current_level = load(Levels.get_level_scene_name(initial_level)).instantiate()
	add_child(current_level)
	current_level.spawn_player(Hardpoints.Id.Default_Id, player)

func start_game():
	fade_in()
	current_level = load(Levels.get_level_scene_name(initial_level)).instantiate()
	add_child(current_level)
	current_level.spawn_player(Hardpoints.Id.Default_Id, player)
	player.state_logic.unlock_player()

func change_level(new_level: Levels.LevelId, hardpoint_id: Hardpoints.Id) -> void:
	fading.speed_scale = 1/Constants.fading_time_in_seconds
	fading.play("fade_to_black")
	await get_tree().create_timer(Constants.fading_time_in_seconds).timeout
	remove_child(current_level)
	current_level = load(Levels.get_level_scene_name(new_level)).instantiate()
	add_child(current_level)
	current_level.spawn_player(hardpoint_id, player)
	fade_in()

func reset_spawnpoint_textures() -> void:
	var level: Level = get_child(1) # first child is always CanvasLayer with fading effect
	if level:
		level.reset_spawnpoint_textures()

func fade_out() -> void:
	fading.speed_scale = 1/Constants.fading_time_in_seconds
	fading.play("fade_to_black")
	await get_tree().create_timer(Constants.fading_time_in_seconds).timeout

func fade_in() -> void:
	fading.speed_scale = 1/Constants.fading_time_in_seconds
	fading.play("fade_to_normal")
	await get_tree().create_timer(Constants.fading_time_in_seconds).timeout
