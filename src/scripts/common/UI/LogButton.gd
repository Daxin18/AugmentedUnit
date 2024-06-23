class_name LogButton
extends Button

@export var log_id: Logs.LogId
@export var logs_menu: LogsMenu

var is_updated := false

func update(collected_logs: Array[Logs.LogId]) -> void:
	if is_updated:
		return
	if collected_logs.has(log_id):
		self.disabled = false
		self.text = Logs.get_log_title(log_id)
		is_updated = true

func _on_pressed():
	logs_menu._on_log_button_pressed(log_id)
