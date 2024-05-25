class_name LogsMenu
extends CanvasLayer

@onready var title = $TextureRect/Title
@onready var author = $TextureRect/Author
@onready var text = $TextureRect/Text
@onready var progression_manager: ProgressionManager = get_tree().get_root().get_node("Main").find_child("ProgressionManager")
@onready var log_player: AudioStreamPlayer2D = get_tree().get_root().get_node("Main").find_child("Player").find_child("LogPlayer")
@onready var player_logic: PlayerInteractionLogic = get_tree().get_root().get_node("Main").find_child("Player").find_child("InteractionLogicHolder")

@export var button_containers: Array[Container]
var current_log_id: Logs.LogId

const title_prefix = "Tytul: "
const author_prefix = "Autor: "
const text_prefix = "Tekst: "

func _input(event):
	if Input.is_action_just_pressed("pause"):
		close()

func open() -> void:
	init_text()
	init_buttons()
	self.visible = true

func close() -> void:
	self.visible = false

func init_buttons() -> void:
	if progression_manager:
		var logs = progression_manager.get_collected_logs()
		for container in button_containers:
			for button in container.get_children():
				button.update(logs)

func init_text() -> void:
	update_title("")
	update_author("")
	update_text("")

func update_log_text(log_id: Logs.LogId) -> void:
	update_title(Logs.get_log_title(log_id))
	update_author(Logs.get_log_author(log_id))
	update_text(Logs.get_log_text(log_id))

func update_title(title_string: String) -> void:
	title.text = title_prefix + title_string
	for child in title.get_children():
		child.text = title_prefix + title_string

func update_author(author_string: String) -> void:
	author.text = author_prefix + author_string
	for child in author.get_children():
		child.text = author_prefix + author_string

func update_text(text_string: String) -> void:
	text.text = text_prefix + text_string
	for child in text.get_children():
		child.text = text_prefix + text_string

func update_log_audio(log_id: Logs.LogId) -> void:
	current_log_id = log_id



func _on_log_button_pressed(log_id: Logs.LogId) -> void:
	update_log_text(log_id)
	update_log_audio(log_id)

func _on_play_pressed():
	log_player.stop()
	player_logic.play_log(current_log_id)
