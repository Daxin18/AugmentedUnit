class_name SaveData
extends Node

# for saving
static var logs: Array[Logs.LogId]
static var mods: Array[Modifications.Mod]
static var level: Levels.LevelId
static var spawnpoint: Vector2

# utils
static var save_name: String = "TEST.save"
static var save_location: String = "user://"

static var general_section: String = "General"
static var logs_value_name: String = "logs"
static var mods_value_name: String = "mods"
static var level_value_name: String = "level"
static var spawnpoint_value_name: String = "spawnpoint"

static func set_state(new_logs: Array[Logs.LogId],\
new_mods: Array[Modifications.Mod], \
new_level: Levels.LevelId, \
new_spawnpoint: Vector2\
) -> void:
	logs = new_logs
	mods = new_mods
	level = new_level
	spawnpoint = new_spawnpoint

static func set_save(slot_name: String) -> void:
	save_name = slot_name

static func save_state() -> void:
	var config_file = ConfigFile.new()
	var path = save_location + save_name
	
	config_file.set_value(general_section, logs_value_name, logs)
	config_file.set_value(general_section, mods_value_name, mods)
	config_file.set_value(general_section, level_value_name, level)
	config_file.set_value(general_section, spawnpoint_value_name, spawnpoint)
	
	var error: = config_file.save(path)
	if error:
		print("An error has occured while saving data: ", error)


static func load_state(filename: String) -> void:
	var config_file: = ConfigFile.new()
	var path = save_location + filename
	var error: = config_file.load(path)
	
	if error:
		print("An error has occured while loading data: ", error)
		return
	
	logs = config_file.get_value(general_section, logs_value_name, logs)
	mods = config_file.get_value(general_section, mods_value_name, mods)
	level = config_file.get_value(general_section, level_value_name, level)
	spawnpoint = config_file.get_value(general_section, spawnpoint_value_name, spawnpoint)
	

