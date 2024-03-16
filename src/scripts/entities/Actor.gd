class_name Actor
extends CharacterBody2D

@onready var sprite = $Sprite

@export var is_facing_left: = false
@export var flipped: = false

func _process(delta):
	flipped = sprite.flip_h

func _set_facing_left(new_is_facing_left: bool) -> void:
	is_facing_left = new_is_facing_left
	sprite.flip_h = is_facing_left
