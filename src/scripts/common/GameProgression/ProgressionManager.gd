class_name ProgressionManager
extends Node

# exporting all variables for trackability in debugger
@export var collected_logs: Array[Logs.LogId] = []
@export var collected_mods: Array[Modifications.Mod] = []
@export var endgame: bool = false
@export var capybara: bool = false
@export var power: bool = false
@export var endgame_timer: float = 0


func _ready():
	endgame_timer = Constants.endgame_time
	load_data()

func _process(delta):
	if endgame:
		endgame_timer -= delta
		if endgame_timer <= 0:
			end_the_game()


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
	SaveData.set_state(collected_logs, collected_mods, level, position)
	SaveData.save_state()

func load_data() -> void:
	if SaveData.logs:
		collected_logs = SaveData.logs
	if SaveData.mods:
		collected_mods = SaveData.mods

func end_the_game() -> void:
	endgame = false
	pass

func is_power() -> bool:
	return power

func enable_power() -> void:
	power = true

func stop_timer() -> void:
	endgame = false
