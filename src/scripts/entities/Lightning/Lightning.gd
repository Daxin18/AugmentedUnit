class_name Lightning
extends Lethal

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var audio = $AudioStreamPlayer2D

const l1 = preload("res://src/assets/entities/lightning/sounds/Lightning_1.wav")
const l2 = preload("res://src/assets/entities/lightning/sounds/Lightning_2.wav")
const l3 = preload("res://src/assets/entities/lightning/sounds/Lightning_3.wav")

const sounds = [l1, l2, l3]

func _ready():
	init()
	await get_tree().create_timer(Constants.lightning_lifetime).timeout
	sprite.queue_free()
	collision.queue_free()
	await get_tree().create_timer(5).timeout
	queue_free()

func init():
	var rng = RandomNumberGenerator.new()
	var image = rng.randi_range(0,2)
	var sound = rng.randi_range(0,2)
	sprite.frame = image
	audio.stream = sounds[sound]
	audio.play()
