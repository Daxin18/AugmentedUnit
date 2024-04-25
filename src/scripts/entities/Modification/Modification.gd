class_name Modification
extends Interactable

@export var mod: Modifications.Mod

@onready var sprite: Sprite2D = $Sprite2D
var win_scene: = preload("res://src/scenes/common/UI/Win.tscn")
var spawn_win: = false

var mod_frame: Dictionary = {
	Modifications.Mod.dash: 0,
	Modifications.Mod.double_jump: 1,
	Modifications.Mod.scream: 2,
	Modifications.Mod.DEM: 3,
}

func _ready():
	sprite.frame = mod_frame[mod]

func interact(entity: Actor) -> void:
	if entity is Player:
		entity.state_logic.unlock_modification(mod)
		# this is temporary
		if mod == Modifications.Mod.DEM:
			entity.state_logic.block_player()
			var win = win_scene.instantiate()
			win.global_position = entity.global_position + Vector2(-320, -180)
			get_tree().get_root().get_child(0).add_child(win)
			wait(8)
			while(spawn_win):
				entity.state_logic.die()
				await get_tree().create_timer(.5).timeout
			get_tree().change_scene_to_file("res://src/scenes/common/UI/Menu.tscn")
		# temporary ends here
		queue_free()

func wait(time: int) -> void:
	spawn_win = true
	await get_tree().create_timer(time).timeout
	spawn_win = false
