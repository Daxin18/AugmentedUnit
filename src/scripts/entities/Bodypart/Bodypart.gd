class_name Bodypart
extends RigidBody2D

@export var part: Bodypart.Part

enum Part {
	Torso = 0,
	Head = 1,
	LArm = 2,
	RArm = 3,
	LLeg = 4,
	RLeg = 5
}

func _ready():
	$Sprite.frame = part
	await get_tree().create_timer(Constants.bodypart_lifetime).timeout
	queue_free()
