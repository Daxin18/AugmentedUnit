class_name PauseMenu
extends CanvasLayer

@onready var save_button = $CenterContainer/VBoxContainer/Save
@onready var logs_menu = $LogsMenu

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS # allows meenu to work when paused

func _input(event):
	if Input.is_action_just_pressed("pause"):
		save_button.disabled = false # to reset the save button
		toggle_pause()

# might not use that if the logs are supposed to play andd stuff
func toggle_pause() -> void:
	self.visible = not self.visible
	get_tree().paused = not get_tree().paused


func _on_continue_pressed():
	toggle_pause()

# this button might get deleted as we're gonna save on every respawnpoint (XD, nope)
func _on_save_pressed():
	var manager = get_tree().get_root().get_node("Main").find_child("LevelManager")
	manager.save()
	save_button.disabled = true

func _on_logs_pressed():
	logs_menu.open()

func _on_menu_pressed():
	toggle_pause()
	get_tree().change_scene_to_file("res://src/scenes/common/UI/Menu.tscn")
