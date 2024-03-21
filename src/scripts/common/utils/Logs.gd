class_name Logs
extends Node

enum LogId {
	dog_log,
	test_log,
	Jan_1,
	Jacek_1
}
const dog_audio = preload("res://PoC/everything_goes_here/Dog single bark.wav")
const test_audio = preload("res://src/assets/entities/log/sounds/test_log.wav")

# this dict
# id: name - text - audio_to_play
# having them all here will make life easier
const logs: Dictionary = {
	LogId.dog_log: ["dog", "DOG", dog_audio],
	LogId.test_log: ["log_name", "log_text", test_audio],
	LogId.Jan_1: ["Lorem", "Ipsum", test_audio],
	LogId.Jacek_1: ["Lorem Ipsum", "TEXT", test_audio]
}

static func get_log_audio(log_id: LogId) -> AudioStream:
	var log_data = logs.get(log_id)
	if log_data:
		return log_data[2]
	return null

# this will be needed later
static func record_log_pickup(logId: LogId) -> void:
	pass
