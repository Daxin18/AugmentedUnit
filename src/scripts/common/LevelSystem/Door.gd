class_name Door
extends Interactable

@export_file("*.tscn") var next_level: String
@export var next_level_hardpoint: Hardpoints.Id

@export var hardpoint_id: Hardpoints.Id
@export var hardpoint_on_left: = false

@onready var hardpoint = $Hardpoint

func _ready() -> void:
	log_blocks_interaction = true
	hardpoint.set_id(hardpoint_id)
	if hardpoint_on_left:
		hardpoint.position.x = -hardpoint.position.x

func interact(entity: Actor) -> void:
	var manager = get_tree().get_root().get_node("Main").find_child("LevelManager")
	manager.change_level(next_level, next_level_hardpoint)
