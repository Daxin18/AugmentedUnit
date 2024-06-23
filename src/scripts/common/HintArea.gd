class_name HintArea
extends Area2D

@export var text: String

func _on_entered(body) -> void:
	if body is Player:
		body.hint.text = text
		body.hint.visible = true

func _on_exited(body) -> void:
	if body is Player:
		body.hint.visible = false
