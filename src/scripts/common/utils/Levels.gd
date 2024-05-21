class_name Levels
extends Node

enum LevelId {
	Cargo,
	Cabins,
	Labo,
	Deck,
	Reactor,
	Armory,
	Submarine
}

const levels: Dictionary = {
	LevelId.Cargo: ["Magazyn", "res://src/scenes/levels/Cargo.tscn"],
	LevelId.Cabins: ["Kajuty", "res://src/scenes/levels/Cabins.tscn"],
	LevelId.Labo: ["Laboratorium", "res://src/scenes/levels/Labo.tscn"],
	LevelId.Deck: ["Poklad", "res://src/scenes/levels/Deck.tscn"],
	LevelId.Reactor: ["Reaktor", "res://src/scenes/levels/Reactor.tscn"],
	LevelId.Submarine: ["Lodz podwodna", "res://src/scenes/levels/Submarine.tscn"],
	LevelId.Armory: ["Zbrojownia","res://src/scenes/levels/Armory.tscn" ]
}

static func get_level_name(id: LevelId) -> String:
	return levels.get(id)[0]

static func get_level_scene_name(id: LevelId) -> String:
	return levels.get(id)[1]
