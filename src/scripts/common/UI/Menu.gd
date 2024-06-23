class_name Menu
extends Control

@onready var button_play: = $VBoxContainer/Play
@onready var button_options: = $VBoxContainer/Options
@onready var button_quit: = $VBoxContainer/Quit
@onready var save_menu: = $SaveMenu

func _ready():
	global_position = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func connect_buttons() -> void:
	button_play.pressed.connect(self.play)
	button_options.pressed.connect(self.options)
	button_quit.pressed.connect(self.quit)

func play() -> void:
	save_menu.visible = true
	# SaveData.load_state("TEST.save")
	# get_tree().change_scene_to_file("res://src/scenes/Main.tscn")

# might want to do thiss one with different type of button (popup-button)
func options() -> void:
	pass

func quit() -> void:
	get_tree().quit()


func _on_play_pressed():
	play()

func _on_options_pressed():
	options()

func _on_quit_pressed():
	quit()
