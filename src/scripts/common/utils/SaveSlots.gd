class_name SaveSlots
extends Node

enum Names {
	Slot_1,
	Slot_2,
	Slot_3,
	Slot_4
}

const mapping: Dictionary = {
	Names.Slot_1: "Zapis 1",
	Names.Slot_2: "Zapis 2",
	Names.Slot_3: "Zapis 3",
	Names.Slot_4: "Zapis 4",
}

static func get_slot_name(slot: Names) -> String:
	return mapping[slot]
