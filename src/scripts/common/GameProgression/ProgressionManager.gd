class_name ProgressionManager
extends Node

# exporting all variables for trackability in debugger
@export var collected_logs: Array[Logs.LogId] = []
@export var collected_mods: Array[Modifications.Mod] = []

#endgame related
@export var endgame: bool = false
@export var capybara: bool = false
@export var power: bool = false
@export var endgame_timer: float = 0

#time tracking
@export var total_time: float = 0
@export var track_time: bool = true

# utils
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
var defeat_scene: = preload("res://src/scenes/common/UI/Defeat.tscn")

func _ready():
	endgame_timer = Constants.endgame_time
	load_data()

func _process(delta):
	if endgame:
		endgame_timer -= delta
		if endgame_timer <= 0:
			end_the_game()
	if track_time:
		total_time += delta
	


# there must be a better way to do this
func record_log_pickup(item: Logs.LogId) -> void:
	if not collected_logs.has(item):
		collected_logs.append(item)
	print("Log " + str(Logs.LogId.keys()[item]) + " collected")

func record_mod_pickup(item: Modifications.Mod) -> void:
	if not collected_mods.has(item):
		collected_mods.append(item)
		if item == Modifications.Mod.DEM:
			start_endgame(Levels.jump_and_groove_1)
	print("Modification " + str(Modifications.Mod.keys()[item]) + " collected")

func get_collected_logs() -> Array[Logs.LogId]:
	return collected_logs

func get_collected_mods() -> Array[Modifications.Mod]:
	return collected_mods

func is_endgame() -> bool:
	return endgame

func is_capybara() -> bool:
	return capybara

func CAPYBARA() -> void:
	var level_manager = $"../LevelManager"
	level_manager.set_music_independant(Levels.capybara)
	capybara = true

# this will make everything alive and activate the timer (XD)
func start_endgame(endgame_music: AudioStream):
	var level_manager = $"../LevelManager"
	level_manager.set_music_independant(endgame_music)
	endgame_timer = Constants.endgame_time
	endgame = true

func save(position: Vector2, level: Levels.LevelId) -> void:
	SaveData.set_state(collected_logs, collected_mods, level, position, total_time)
	SaveData.save_state()

func load_data() -> void:
	if SaveData.logs:
		collected_logs = SaveData.logs
	if SaveData.mods:
		collected_mods = SaveData.mods

func end_the_game() -> void:
	endgame = false
	track_time = false
	var player: Player = get_tree().get_root().get_node("Main").find_child("Player")
	player.state_logic.block_player()
	var defeat = defeat_scene.instantiate()
	defeat.global_position = player.global_position + Vector2(-320, -180)
	get_tree().get_root().get_child(0).add_child(defeat)
	audio.stream = load("res://src/assets/levels/endgame/boom.mp3")
	audio.play()
	reset_save()
	await get_tree().create_timer(6).timeout
	get_tree().change_scene_to_file("res://src/scenes/common/UI/Menu.tscn")


func is_power() -> bool:
	return power

func enable_power() -> void:
	power = true
	audio.stream = load("res://src/assets/levels/endgame/Power_up.mp3")
	audio.play()

func stop_timer() -> void:
	endgame = false
	track_time = false

func reset_save() -> void:
	SaveData.load_default()
	SaveData.save_state()
	pass

func get_total_time_string() -> String:
	var mins = int(total_time) / 60
	var secs = int(total_time) % 60
	var hours = 0
	
	if mins > 60:
		hours = mins / 60
		mins = mins % 60
	
	var h_str: String = str(hours)
	var min_str: String = str(mins)
	var s_str: String = str(secs)
	
	if hours < 10:
		h_str = "0" + h_str
	if mins < 10:
		min_str = "0" + min_str
	if secs < 10:
		s_str = "0" + s_str
	
	return h_str + ":" + min_str + ":" + s_str
