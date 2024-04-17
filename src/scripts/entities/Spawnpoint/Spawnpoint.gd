class_name RespawnStation
extends Interactable

@onready var hardpoint: Node2D = $Hardpoint
@onready var sprite: Sprite2D = $Sprite2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var is_current_spawnpoint: = false

func interact(entity: Actor) -> void:
	if entity is Player:
		entity.state_logic.set_spawnpoint(hardpoint.global_position)
		set_current_spawnpoint(true)
		audio.play()

func set_current_spawnpoint(set_to: bool) -> void:
	is_current_spawnpoint = set_to
	if is_current_spawnpoint:
		sprite.frame = 1
	else:
		sprite.frame = 0
