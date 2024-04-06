class_name PlayerAudioManager
extends Node

@onready var sfx_player = $"SFXPlayer"

func play_sfx(sound: Sounds) -> void:
	sfx_player.stream = mapping[sound]
	sfx_player.play()

enum Sounds {
	Death
}

const death_sound = preload("res://src/assets/entities/player/sounds/death_sound.wav")

const mapping: Dictionary = {
	Sounds.Death: death_sound
}

