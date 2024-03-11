extends Node2D
class_name Log

var is_for_deletion: = false

func _process(delta):
	pass

func read():
	if not $LogAudio.playing:
		$LogAudio.play()
		is_for_deletion = true
		visible = false

func _check_deletion():
	if is_for_deletion and not $LogAudio.playing:
		queue_free()
