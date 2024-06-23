class_name WinScreen
extends Control

@onready var time: = $TIME
@onready var progression_manager: ProgressionManager = get_tree().get_root().get_node("Main").find_child("ProgressionManager")

const time_prefix = "Czas: "

func _ready():
	time.text = time_prefix + progression_manager.get_total_time_string()

