class_name PlayerInteractionLogic
extends Node

# yes, this implementation assumes the interactables are spread out
# aka there is no place where 2 or more interactables can be in interact_radius at the same time
# it will still work, but only once, only for the furthest interactable as they are assigned on entry
# player will have to move back and into interactable again to interact with it
var current_interactable: Interactable
var parent: Player

func init(player: Player) -> void:
	parent = player

func _process(delta):
	if Input.is_action_just_pressed("interact") \
	and current_interactable \
	and can_interact(current_interactable):
		current_interactable.interact(parent)

func _on_interact_radius_area_entered(area):
	if area is Interactable:
		current_interactable = area

func _on_interact_radius_area_exited(area):
	if area == current_interactable:
		current_interactable = null

func can_interact(interactable: Interactable) -> bool:
	if interactable.log_blocks_interaction:
		return not parent.log_player.playing
	return true

#===========================
# 		Log-specific
#===========================

func play_log(log_id: Logs.LogId) -> void:
	var log_audio = Logs.get_log_audio(log_id)
	if log_audio:
		parent.log_player.stream = log_audio
		parent.log_player.play()
		Logs.record_log_pickup(log_id)
