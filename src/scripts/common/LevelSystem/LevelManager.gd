class_name LevelManager
extends Node

@export var initial_level: Levels.LevelId
@export var player: Player

@onready var fading: = $CanvasLayer/fading
@onready var music: = $AudioStreamPlayer
@onready var progression_manager: = $"../ProgressionManager"

var current_level: Level
var spawn_player: bool = true

func _ready():
	load_state()
	fade_in()
	set_music(initial_level)
	current_level = load(Levels.get_level_scene_name(initial_level)).instantiate()
	add_child(current_level)
	if spawn_player:
		current_level.spawn_player(Hardpoints.Id.Default_Id, player)
	else:
		pass

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
	decide_music_change(current_level.level_id, new_level)
	current_level = load(Levels.get_level_scene_name(new_level)).instantiate()
	add_child(current_level)
	current_level.spawn_player(hardpoint_id, player)
	fade_in()

func reset_spawnpoint_textures() -> void:
	var level: Level = get_child(2) # this is bad, shut up
	if level:
		level.reset_spawnpoint_textures()

# yes, this is hardcoded, yes, it is bad, no, I'm not changing it
func decide_music_change(current: Levels.LevelId, next: Levels.LevelId) -> void:
	if progression_manager.is_capybara():
		return
	if progression_manager.is_endgame():
		return
	if current == next \
	or (current == Levels.LevelId.Submarine and next == Levels.LevelId.Cargo) \
	or (current == Levels.LevelId.Cargo and next == Levels.LevelId.Submarine) \
	or (current == Levels.LevelId.Labo and next == Levels.LevelId.Reactor) \
	or (current == Levels.LevelId.Reactor and next == Levels.LevelId.Labo):
		return
	set_music(next)

func set_music(level: Levels.LevelId) -> void:
	var music_audio = Levels.get_level_music(level)
	music.stop()
	music.stream = music_audio
	music.play()

func set_music_independant(music_audio: AudioStream) -> void:
	music.stop()
	music.stream = music_audio
	music.play()

func fade_out() -> void:
	fading.speed_scale = 1/Constants.fading_time_in_seconds
	fading.play("fade_to_black")
	await get_tree().create_timer(Constants.fading_time_in_seconds).timeout

func fade_in() -> void:
	fading.speed_scale = 1/Constants.fading_time_in_seconds
	fading.play("fade_to_normal")
	await get_tree().create_timer(Constants.fading_time_in_seconds).timeout

func save() -> void:
	progression_manager.save(player.global_position, current_level.level_id)

func load_state() -> void:
	if SaveData.level:
		initial_level = SaveData.level
	if SaveData.mods:
		for mod in SaveData.mods:
			player.state_logic.unlock_modification(mod)
	if SaveData.spawnpoint:
		var spawnpoint = SaveData.spawnpoint
		player.global_position = spawnpoint
		player.state_logic.set_spawnpoint(spawnpoint) #set player spawnpoint
		player.state_machine.init(player) # reset state so player doesn't float
		spawn_player = false
