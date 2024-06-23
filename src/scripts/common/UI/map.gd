class_name Map
extends CanvasLayer

const red_alarm: = "[color=red]Alarm[/color]"
const red_power: = "[color=red]Zasilanie[/color]"
const green_alarm: = "[color=green]Alarm[/color]"
const green_power: = "[color=green]Zasilanie[/color]"

@onready var alarm: = $TextureRect2/ColorRect/Alarm
@onready var power: = $TextureRect2/ColorRect/Power
@onready var progression_manager: ProgressionManager = $"../ProgressionManager"

func _process(delta):
	self.visible = Input.is_action_pressed("Map")
	if progression_manager.endgame:
		alarm.text = green_alarm
	else:
		alarm.text = red_alarm
	
	if progression_manager.power:
		power.text = green_power
	else:
		power.text = red_power
