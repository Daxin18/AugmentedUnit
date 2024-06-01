class_name SubmarineInteractable
extends Interactable

@onready var progression_manager: ProgressionManager = get_tree().get_root().get_node("Main").find_child("ProgressionManager")
var win_scene: = preload("res://src/scenes/common/UI/Win.tscn")

func interact(body: Actor) -> void:
	if body is Player \
	and progression_manager.is_endgame() \
	and progression_manager.is_power():
		progression_manager.stop_timer()
		body.state_logic.block_player()
		var win = win_scene.instantiate()
		win.global_position = body.global_position + Vector2(-320, -180)
		get_tree().get_root().get_child(0).add_child(win)
		progression_manager.CAPYBARA()
		await get_tree().create_timer(15).timeout
		get_tree().change_scene_to_file("res://src/scenes/common/UI/Menu.tscn")
