class_name Anomaly
extends  Node2D

var audio_idle: = preload("res://src/assets/entities/anomaly/sounds/anomaly_idle.wav")
var audio_active: = preload("res://src/assets/entities/anomaly/sounds/anomaly_active.wav")

@export var min_idle_time: = 8
@export var max_idle_time: = 20
@export var confuses_for: = 10

var is_active: = false
var is_activating: = false
var rng: = RandomNumberGenerator.new()
var exists: = true

const anomaly_active_time: = 5
const anomaly_idle_time: = 3.6

@onready var audio: = $AudioStreamPlayer2D
@onready var animation: = $Sprite2D/AnimationPlayer
@onready var tp_point: = $tp_point
@onready var area: = $Area2D

func set_hitbox(enabled: bool) -> void:
	area.set_collision_mask_value(1, enabled)

func _process(delta: float) -> void:
	if not is_activating:
		if not is_active:
			go_idle()
		var time = rng.randf_range(min_idle_time, max_idle_time)
		activate_after(time)

func _exit_tree() -> void:
	exists = false

func activate_after(time: float) -> void:
	is_activating = true
	if exists:
		await get_tree().create_timer(time).timeout
	go_active()
	if exists:
		await get_tree().create_timer(anomaly_active_time).timeout
	is_activating = false
	is_active = false

func go_active() -> void:
	is_active = true
	set_hitbox(true)
	audio.stream = audio_active
	audio.play()
	animation.play("anomaly_active")

func go_idle() -> void:
	audio.stream = audio_idle
	audio.autoplay = true
	set_hitbox(false)
	audio.play()
	animation.play("anomaly_idle")

func confuse(player: Player) -> void:
	player.state_logic.apply_confusion(confuses_for)

func teleport(player: Player) -> void:
	var level_manager = get_tree().get_root().get_node("Main").find_child("LevelManager")
	var anomalies: = []
	for child in level_manager.get_children(): # find_child("Labo") doesn't work
		if child is Labo:
			anomalies = child.find_child("Anomalies").get_children()
	if anomalies.is_empty():
		print("something's wrong")
		return
	anomalies.remove_at(anomalies.find(self))
	var idx: = rng.randi_range(0, anomalies.size() - 1)
	player.global_position = anomalies[idx].tp_point.global_position

func do_something(player: Player) -> void:
	var something = rng.randi_range(0, 1)
	match something:
		0:
			confuse(player)
			return
		1:
			teleport(player)
			return


func _on_area_2d_body_entered(body) -> void:
	if body is Player:
		do_something(body)
