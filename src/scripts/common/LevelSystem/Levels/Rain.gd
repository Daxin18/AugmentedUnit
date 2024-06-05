class_name Rain
extends Sprite2D

@onready var player: Player = get_tree().get_root().get_node("Main").find_child("Player")

func _process(delta):
	play_anim()
	follow_player()

func play_anim():
	var id = self.frame + 1
	if id >= 39:
		self.frame = 0
	else:
		self.frame = id

func follow_player():
	var pos = player.find_child("Camera").global_position
	self.global_position = pos
