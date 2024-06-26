class_name Door
extends Interactable

@export var next_level_id: Levels.LevelId
@export var next_level_hardpoint: Hardpoints.Id

@export var hardpoint_id: Hardpoints.Id
@export var hardpoint_on_left: = false

@onready var hardpoint = $Hardpoint

# this prevents player from loading TOO MANY levels when spam-clicking during fading animation
var can_transition: = true

func _ready() -> void:
	log_blocks_interaction = true
	hardpoint.set_id(hardpoint_id)
	if hardpoint_on_left:
		hardpoint.position.x = -hardpoint.position.x

func interact(entity: Actor) -> void:
	var manager = get_tree().get_root().get_node("Main").find_child("LevelManager")
	#=======Deck lightning issue fix
	for child in manager.get_children():
		if child is Deck:
			child.exit()
	#=======================
	if can_transition: 
		can_transition = false
		manager.change_level(next_level_id, next_level_hardpoint)
