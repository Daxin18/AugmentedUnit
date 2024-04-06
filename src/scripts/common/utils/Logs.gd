class_name Logs
extends Node

enum LogId {
	dog_log,
	test_log,
	Jan_1,
	Jacek_1,
	Robert_1,
	Robert_2,
	Jab_1,
	Jab_2
}
const dog_audio = preload("res://PoC/everything_goes_here/Dog single bark.wav")
const test_audio = preload("res://src/assets/entities/log/sounds/test_log.wav")
const jan_1_audio = preload("res://src/assets/entities/log/sounds/uncategorized/Jan_1.wav")
const jacek_1_audio = preload("res://src/assets/entities/log/sounds/Jacek/Początek znajomości.wav")
const robert_1_audio = preload("res://src/assets/entities/log/sounds/Robert/Po co to tu jest.wav")
const robert_2_audio = preload("res://src/assets/entities/log/sounds/Robert/Ci ludzie....wav")
const jab_1_audio = preload("res://src/assets/entities/log/sounds/Jabłonowski/Podziw bronie.wav")
const jab_2_audio = preload("res://src/assets/entities/log/sounds/Jabłonowski/On musi z kimś porozmawiać.wav")

# this dict
# id: name - text - audio_to_play
# having them all here will make life easier
const logs: Dictionary = {
	LogId.dog_log: ["dog", "DOG", dog_audio],
	LogId.test_log: ["log_name", "log_text", test_audio],
	LogId.Jan_1:[
		"Ostatnie słowa",
		"Coś tu jest nie tak, coś jest nie tak! Coś pojawiło się na statku... O Boże... idzie tu! To tu idzie! Aaaaaaa!!!",
		jan_1_audio
	],
	LogId.Jacek_1: [
		"Początek znajomości",
		"Warta w magazynie nie jest taka zła, dzięki niej mogę czasem porozmawiać z Robertem. Chciałbym kiedyś pomóc mu z eksperymentami, zamiast tylko siedzieć w różnych częściach statku.",
		jacek_1_audio
	],
	LogId.Robert_1: [
		"Po co to tu jest?",
		"Augmented Unit... Nie rozumiem, po co to tu trzymamy... To tak jakby ludzie oczekiwali, że ta cała operacja nie wypali, a tak nie będzie! Ale jeśli już... to lepiej, żeby ten robot odzyskał wszystkie dane, moja praca nie może pójść na marnę!",
		robert_1_audio
	],
	LogId.Robert_2: [
		"Ci ludzie...",
		"To niewiarygodne jak dużo trzeba gadać z tymi ludźmi, zanim cokolwiek dostanę z magazynu... Czy oni nie rozumieją, że w mojej pracy CZAS JEST KLUCZOWY?!",
		robert_2_audio
	],
	LogId.Jab_1: [
		"Podziw: bronie",
		"Za każdym razem, gdy tu przychodzę, nie mogę się powstrzymać przed podziwianiem tej kolekcji broni... Ten statek to prawdziwe dzieło sztuki!",
		jab_1_audio
	],
	LogId.Jab_2: [
		"On musi z kimś porozmawiać",
		"On oszalał! Wczoraj gadał jakieś głupoty, a teraz włamał się do zbrojowni! Może ktoś musi z nim porozmawiać...",
		jab_2_audio
	]
}

static func get_log_audio(log_id: LogId) -> AudioStream:
	var log_data = logs.get(log_id)
	if log_data:
		return log_data[2]
	return null

# this will be needed later
static func record_log_pickup(logId: LogId) -> void:
	pass
