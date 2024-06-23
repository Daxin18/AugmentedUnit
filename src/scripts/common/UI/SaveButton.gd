class_name SaveButton
extends Button

@export var slot_id: SaveSlots.Names

func _ready():
	self.text = SaveSlots.get_slot_name(slot_id)


func _on_pressed():
	var save_name = SaveSlots.get_slot_name(slot_id)
	SaveData.load_state(save_name)
	SaveData.set_save(save_name)
	get_tree().change_scene_to_file("res://src/scenes/Main.tscn")
