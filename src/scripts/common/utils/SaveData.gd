class_name SaveData
extends Node

static var logs: Array[Logs.LogId]
static var mods: Array[Modifications.Mod]
static var level: Levels.LevelId
static var spawnpoint: Vector2

static func set_state(new_logs: Array[Logs.LogId],\
new_mods: Array[Modifications.Mod], \
new_level: Levels.LevelId, \
new_spawnpoint: Vector2\
) -> void:
	logs = new_logs
	mods = new_mods
	level = new_level
	spawnpoint = new_spawnpoint

static func save_state(filename: String) -> void:
	var save_game = FileAccess.open("user://" + filename, FileAccess.WRITE)
	var save_dict = get_save_dict()
	var json_string = JSON.stringify(save_dict)
	save_game.store_line(json_string)

static func get_save_dict() -> Dictionary:
	var save_dict = {
		"logs": logs,
		"mods": mods,
		"level": level,
		"spawnpoint": spawnpoint
	}
	return save_dict

static func load_state(filename: String) -> void:
	var full_path = "user://" + filename
	if not FileAccess.file_exists(full_path):
		print("Provided save file not found")
		return
	
	var saved_game = FileAccess.open("user://" + filename, FileAccess.READ)
	while saved_game.get_position() < saved_game.get_length():
		var json_string = saved_game.get_line()
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		var saved_data = json.get_data()
		logs = saved_data["logs"]
		mods = saved_data["mods"]
		level = saved_data["level"]
		spawnpoint = saved_data["spawnpoint"]
	
	
	
	
	
	
	
	
	
	
	
