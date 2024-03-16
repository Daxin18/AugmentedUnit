class_name PlayerInteractionLogic
extends Node

# yes, this implementation assumes the interactables are spread out
# aka there is no place where 2+ interactables can be in interact_radius at the same time
var current_interactable: Interactable
var parent: Player

func init(player: Player) -> void:
	parent = player

func _process(delta):
	if Input.is_action_just_pressed("interact") \
	and current_interactable \
	and can_interact():
		current_interactable.interact(parent)

func _on_interact_radius_body_entered(body):
	if body is Interactable:
		current_interactable = body

func _on_interact_radius_body_exited(body):
	if body == current_interactable:
		current_interactable = null

func can_interact() -> bool:
	return not parent.audio_player.playing

#===========================
# 		Log-specific
#===========================

func play_log(log_id: Logs.LogId) -> void:
	var log_audio = Logs.get_log_audio(log_id)
	if log_audio:
		parent.audio_player.stream = log_audio
		parent.audio_player.play()
		Logs.record_log_pickup(log_id)
