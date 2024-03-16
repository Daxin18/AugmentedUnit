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
# this class will hold data about logs
# id - name - text - audio_to_play
# having them all here will make life easier
#
# might want to add some way of tracking logs here
const logs: Dictionary= {
	LogId.dog_log: ["dog", "DOG", dog_audio],
	LogId.test_log: ["log_name", "log_text", test_audio],
	LogId.Jan_1: ["Lorem", "Ipsum", test_audio],
	LogId.Jacek_1: ["Lorem Ipsum", "TEXT", test_audio]
}

static func get_log_audio(log_id: LogId) -> AudioStream:
	return logs.get(log_id)[2] # default to null

# this will be needed later
static func record_log_pickup(logId: LogId) -> void:
	pass
