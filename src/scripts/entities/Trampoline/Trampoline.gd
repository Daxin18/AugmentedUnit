class_name Trampoline
extends Node2D

@export var power: = 1000
@export var movement_lock_duration: = .3

@onready var animation = $Sprite2D/AnimationPlayer
@onready var audio = $AudioStreamPlayer2D
@onready var jump_vector: = Vector2(0, -power).rotated(self.rotation)

func _ready():
	animation.play("anim")


func _on_jumper_body_entered(body):
	if body is Player:
		body.state_logic.trampoline_player(jump_vector, movement_lock_duration)
		audio.play()
