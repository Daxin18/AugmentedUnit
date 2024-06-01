class_name Levels
extends Node

enum LevelId {
	Cargo,
	Cabins,
	Labo,
	Deck,
	Reactor,
	Armory,
	Submarine,
	Tutorial
}

# all of the music was created with Suno AI
# https://suno.com
const ghost_ship_disturbing = preload("res://src/assets/levels/music/Ghost Ship (disturbing).mp3")
const ghost_ship_happy = preload("res://src/assets/levels/music/Ghost Ship (happy).mp3")
const nervous_steps = preload("res://src/assets/levels/music/Nervous Steps.mp3")
const nervous_steps_1 = preload("res://src/assets/levels/music/Nervous Steps (1).mp3")
const pixelated_nightmare = preload("res://src/assets/levels/music/Pixelated Nightmare.mp3")
const jump_and_groove = preload("res://src/assets/levels/music/final/Jump and Groove.mp3")
const jump_and_groove_1 = preload("res://src/assets/levels/music/final/Jump and Groove (1).mp3")
const beyond_reality = preload("res://src/assets/levels/music/Beyond Reality.mp3")
const capybara = preload("res://src/assets/levels/music/CAPYBARA.mp3")

const levels: Dictionary = {
	LevelId.Cargo: ["Magazyn", "res://src/scenes/levels/Cargo.tscn", pixelated_nightmare],
	LevelId.Cabins: ["Kajuty", "res://src/scenes/levels/Cabins.tscn", nervous_steps_1],
	LevelId.Labo: ["Laboratorium", "res://src/scenes/levels/Labo.tscn", ghost_ship_happy],
	LevelId.Deck: ["Poklad", "res://src/scenes/levels/Deck.tscn", nervous_steps],
	LevelId.Reactor: ["Reaktor", "res://src/scenes/levels/Reactor.tscn", pixelated_nightmare],
	LevelId.Submarine: ["Lodz podwodna", "res://src/scenes/levels/Submarine.tscn", ghost_ship_happy],
	LevelId.Armory: ["Zbrojownia","res://src/scenes/levels/Armory.tscn", ghost_ship_disturbing],
	LevelId.Tutorial: ["Trening", "res://src/scenes/levels/Tutorial.tscn", beyond_reality]
}

static func get_level_name(id: LevelId) -> String:
	return levels.get(id)[0]

static func get_level_scene_name(id: LevelId) -> String:
	return levels.get(id)[1]

static func get_level_music(id: LevelId) -> AudioStream:
	return levels.get(id)[2]

static func get_dem_endgame_audio() -> AudioStream:
	return jump_and_groove_1

static func get_nuke_endgame_audio() -> AudioStream:
	return jump_and_groove	
