class_name SaveSlots
extends Node

enum Names {
	Slot_1,
	Slot_2,
	Slot_3,
	Slot_4
}

const mapping: Dictionary = {
	Names.Slot_1: "Zapis_1",
	Names.Slot_2: "Zapis_2",
	Names.Slot_3: "Zapis_3",
	Names.Slot_4: "Zapis_4",
}

static func get_slot_name(slot: Names) -> String:
	return mapping[slot]
