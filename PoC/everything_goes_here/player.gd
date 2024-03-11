extends CharacterBody2D

@export var movespeed: = 300
@export var gravity_strength := 20
@export var jump_strength: = 1000
@export var dash_speed: = 10000
@export var dash_slowdown: = 20
@export var is_double_jump_active: = true
@export var is_dash_active: = true

var jump_count = 2
var dash_count = 1

var jump_cooldown = 2
var dash_cooldown = 2
var closest_log: Log = null

@onready var feet: = $Feet
var is_facing_right: = true

func _ready():
	velocity = Vector2.ZERO

func _process(delta):
	_calculate_velocity()
	reset_movement_mods()
	move_and_slide()
	if Input.is_action_just_pressed("interact"):
		pickup_log()

func _calculate_velocity():
	#gravity
	velocity.y = velocity.y + gravity_strength
	
	#jump
	if Input.is_action_just_pressed("jump"):
		jump()
	
	#move
	set_move_velocity()
	
	#dash
	if Input.is_action_just_pressed("dash"):
		dash()

func jump():
	if jump_count > 0:
		velocity.y = velocity.y - jump_strength
		jump_count = jump_count - 1
		start_jump_cooldown()

func dash():
	if is_dash_active and dash_count > 0:
		dash_count = dash_count - 1
		if is_facing_right:
			velocity.x = velocity.x + 500
		else:
			velocity.x = velocity.x - 500
		start_dash_cooldown()

func set_move_velocity():
	if velocity.x > movespeed:
		velocity.x = velocity.x - dash_slowdown
	elif velocity.x < - movespeed:
		velocity.x = velocity.x + dash_slowdown
	else:
		if Input.is_action_pressed("move_left"):
			velocity.x = - movespeed
			is_facing_right = false
		elif Input.is_action_pressed("move_right"):
			velocity.x = movespeed
			is_facing_right = true
		else:
			velocity.x = 0

func start_jump_cooldown():
	await get_tree().create_timer(jump_cooldown).timeout
	jump_count = jump_count + 1

func start_dash_cooldown():
	await get_tree().create_timer(dash_cooldown).timeout
	dash_count = dash_count + 1

func pickup_log():
	closest_log.read()
	closest_log = null

#TODO
func reset_movement_mods():
	if not feet.get_overlapping_areas().is_empty():
		if is_double_jump_active:
			jump_count = 2
		else:
			jump_count = 1
		if is_dash_active:
			dash_count = 1


func _on_pickup_radius_body_entered(body):
	closest_log = body


func _on_pickup_radius_body_exited(body):
	if closest_log == body:
		closest_log = null
