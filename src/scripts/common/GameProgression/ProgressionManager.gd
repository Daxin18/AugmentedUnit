class_name ProgressionManager
extends Node

# exporting all variables for trackability in debugger
@export var collected_logs: Array[Logs.LogId] = []
@export var collected_mods: Array[Modifications.Mod] = []

# there must be a better way to do this
func record_log_pickup(item: Logs.LogId) -> void:
	if not collected_logs.has(item):
		collected_logs.append(item)
	print("Log " + str(Logs.LogId.keys()[item]) + " collected")

func record_mod_pickup(item: Modifications.Mod) -> void:
	if not collected_mods.has(item):
		collected_mods.append(item)
	print("Modification " + str(Modifications.Mod.keys()[item]) + " collected")

func get_collected_logs() -> Array[Logs.LogId]:
	return collected_logs

func get_collected_mods() -> Array[Modifications.Mod]:
	return collected_mods
