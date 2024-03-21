extends Node2D
class_name OBSOLETE_Log

var is_for_deletion: = false

func _process(delta):
	_check_deletion()

func read():
	if not $LogAudio.playing:
		$LogAudio.play()
		is_for_deletion = true
		visible = false

func _check_deletion():
	if is_for_deletion and not $LogAudio.playing:
		queue_free()
