class_name PlayerInteractionLogic
extends Node

# yes, this implementation assumes the interactables are spread out
# aka there is no place where 2 or more interactables can be in interact_radius at the same time
# it will still work, but only once, only for the furthest interactable as they are assigned on entry
# player will have to move back and into interactable again to interact with it
var current_interactable: Interactable
var parent: Player
var progression_manager: ProgressionManager
var log_playing = false

@onready var current_log_hud = $"../CanvasLayer/HUD/CurrentLog"
@onready var log_title_hud = $"../CanvasLayer/HUD/CurrentLog/logTitle"

# valign is custom effect for vertically alligned text
const log_title_valign_prefix = "[valign px=-19]"
const log_title_valign_prefix_long_text = "[valign px=-10]"

func init(player: Player) -> void:
	parent = player
	progression_manager = get_tree().get_root().get_node("Main").find_child("ProgressionManager")
	set_current_log(null)

func _process(delta):
	if Input.is_action_just_pressed("interact") \
	and current_interactable \
	and can_interact(current_interactable):
		current_interactable.interact(parent)
	if log_playing and not parent.log_player.playing:
		set_current_log(null)
		log_playing = false

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
		log_playing = true
		set_current_log(Logs.get_log_title(log_id))
		Logs.record_log_pickup(log_id, progression_manager)

func set_current_log(log_title) -> void:
	if log_title:
		var text_for_title = get_text_for_title(log_title)
		log_title_hud.text = text_for_title
		for child in log_title_hud.get_children():
			child.text = text_for_title
		set_hbox_visibility(true)
	else:
		set_hbox_visibility(false)

func set_hbox_visibility(visibility: bool) -> void:
	for child in current_log_hud.get_children():
		child.visible = visibility

func get_text_for_title(log_title: String) -> String:
	if log_title.length() >= 20:
		return log_title_valign_prefix_long_text + log_title
	else:
		return log_title_valign_prefix + log_title
