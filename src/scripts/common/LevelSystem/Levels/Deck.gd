class_name Deck
extends Level

@export var lightning_spawn_distance: = 300

var rng: = RandomNumberGenerator.new()
var lightning_warning_scene: = preload("res://src/scenes/common/LightningWarning.tscn")
var exit_level: = false

func init_level_mechanics() -> void:
	generate_lightning()

func generate_lightning() -> void:
	while not exit_level:
		if exit_level:
			return
		var wait_for = rng.randf_range(Constants.deck_min_lightning_time, Constants.deck_max_lightning_time)
		await get_tree().create_timer(wait_for).timeout
		if exit_level:
			return
		spawn_lightning()
		if exit_level:
			return


func spawn_lightning() -> void:
	if exit_level:
		return
	var player = get_tree().get_root().get_node("Main").find_child("Player")
	var posx = player.global_position.x + rng.randi_range(-lightning_spawn_distance, lightning_spawn_distance)
	var pos = Vector2(posx, player.global_position.y)
	var warning = lightning_warning_scene.instantiate()
	warning.global_position = pos
	if exit_level:
		return
	get_tree().get_root().add_child(warning)

func exit() -> void:
	exit_level = true
