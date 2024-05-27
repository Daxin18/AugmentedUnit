class_name ProgressionManager
extends Node

# exporting all variables for trackability in debugger
@export var collected_logs: Array[Logs.LogId] = []
@export var collected_mods: Array[Modifications.Mod] = []
@export var endgame: bool = false

func _ready():
	load_data()

# there must be a better way to do this
func record_log_pickup(item: Logs.LogId) -> void:
	if not collected_logs.has(item):
		collected_logs.append(item)
	print("Log " + str(Logs.LogId.keys()[item]) + " collected")

func record_mod_pickup(item: Modifications.Mod) -> void:
	if not collected_mods.has(item):
		collected_mods.append(item)
		if item == Modifications.Mod.DEM:
			start_endgame()
	print("Modification " + str(Modifications.Mod.keys()[item]) + " collected")

func get_collected_logs() -> Array[Logs.LogId]:
	return collected_logs

func get_collected_mods() -> Array[Modifications.Mod]:
	return collected_mods

func is_endgame() -> bool:
	return endgame

# this will make everything alive and activate the timer (XD)
func start_endgame():
	endgame = true

func save(position: Vector2, level: Levels.LevelId) -> void:
	SaveData.set_state(collected_logs, collected_mods, level, position)
	SaveData.save_state("TEST.save")

func load_data() -> void:
	if SaveData.logs:
		collected_logs = SaveData.logs
	if SaveData.mods:
		collected_mods = SaveData.mods


