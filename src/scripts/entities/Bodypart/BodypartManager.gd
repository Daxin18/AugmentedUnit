class_name BodypartManager
extends Node

var bodypart_scene: = "res://src/scenes/entities/Bodypart.tscn"

func spawn_parts(global_position: Vector2) -> void:
	var bodypart
	for i in range(5):
		bodypart = load(bodypart_scene).instantiate()
		bodypart.set("part", i)
		add_child(bodypart)
		bodypart.global_position = global_position
