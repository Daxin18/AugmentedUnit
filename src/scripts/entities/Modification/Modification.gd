class_name Modification
extends Interactable

@export var mod: Modifications.Mod

@onready var sprite: Sprite2D = $Sprite2D

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
		queue_free()
