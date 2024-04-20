class_name LightningWarning
extends Node2D

var lightning_scene = preload("res://src/scenes/common/Lightning.tscn")
@onready var animation = $Sprite2D/AnimationPlayer

func _ready():
	animation.play("anim")
	var rng = RandomNumberGenerator.new()
	await get_tree().create_timer(Constants.lightning_delay).timeout
	var lightning = lightning_scene.instantiate()
	lightning.global_position = self.global_position
	get_tree().get_root().add_child(lightning)
	queue_free()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
