class_name Logs
extends Node

enum LogId {
	dog_log,
	test_log,
	# Cargo
	Jan_1,
	Jacek_1,
	Robert_1,
	Robert_2,
	Jab_1,
	Jab_2,
	# Cabins
	Jab_4,
	Robert_4,
	Jacek_4,
	Robert_5,
	Jacek_5,
	Jab_6,
	Jacek_7,
	Jab_7,
	Jacek_8,
	Jacek_9,
	# Submarine
	Jab_3,
	Jacek_2,
	# Zbrojownia
	Jab_5,
	Jacek_3,
	# Deck
	Robert_3,
	# Lab
	Robert_6,
	Jacek_6,
	Robert_7,
	Jab_8,
	Robert_8
}
const dog_audio = preload("res://PoC/everything_goes_here/Dog single bark.wav")
const test_audio = preload("res://src/assets/entities/log/sounds/test_log.wav")
const jan_1_audio = preload("res://src/assets/entities/log/sounds/uncategorized/Jan_1.wav")
const jacek_1_audio = preload("res://src/assets/entities/log/sounds/Jacek/Początek znajomości.wav")
const jacek_2_audio = preload("res://src/assets/entities/log/sounds/Jacek/Na wszelki wypadek....wav")
const jacek_3_audio = preload("res://src/assets/entities/log/sounds/Jacek/Ostatnie życzenie.wav")
const jacek_4_audio = preload("res://src/assets/entities/log/sounds/Jacek/Nazywa to DEM.wav")
const jacek_5_audio = preload("res://src/assets/entities/log/sounds/Jacek/W końcu jest ciekawie.wav")
const jacek_6_audio = preload("res://src/assets/entities/log/sounds/Jacek/To było dziwne.wav")
const jacek_7_audio = preload("res://src/assets/entities/log/sounds/Jacek/Nie czuje się najlepiej.wav")
const jacek_8_audio = preload("res://src/assets/entities/log/sounds/Jacek/Trzeba go ostrzec.wav")
const jacek_9_audio = preload("res://src/assets/entities/log/sounds/Jacek/Nie mogę tak dłużej.wav")
const robert_1_audio = preload("res://src/assets/entities/log/sounds/Robert/Po co to tu jest.wav")
const robert_2_audio = preload("res://src/assets/entities/log/sounds/Robert/Ci ludzie....wav")
const robert_3_audio = preload("res://src/assets/entities/log/sounds/Robert/Dlaczego statek.wav")
const robert_4_audio = preload("res://src/assets/entities/log/sounds/Robert/Ten szeregowy....wav")
const robert_5_audio = preload("res://src/assets/entities/log/sounds/Robert/Zaczynam się do niego przekonywać....wav")
const robert_6_audio = preload("res://src/assets/entities/log/sounds/Robert/Jest bystry... ale nadal głupi.wav")
const robert_7_audio = preload("res://src/assets/entities/log/sounds/Robert/Za kogo on się uważa.wav")
const robert_8_audio = preload("res://src/assets/entities/log/sounds/Robert/Muszę to zbadać.wav")
const jab_1_audio = preload("res://src/assets/entities/log/sounds/Jabłonowski/Podziw bronie.wav")
const jab_2_audio = preload("res://src/assets/entities/log/sounds/Jabłonowski/On musi z kimś porozmawiać.wav")
const jab_3_audio = preload("res://src/assets/entities/log/sounds/Jabłonowski/Podziw łódź podwodna.wav")
const jab_4_audio = preload("res://src/assets/entities/log/sounds/Jabłonowski/Zrobiłem to....wav")
const jab_5_audio = preload("res://src/assets/entities/log/sounds/Jabłonowski/Waga naszej misji.wav")
const jab_6_audio = preload("res://src/assets/entities/log/sounds/Jabłonowski/Cieszę się że jest szczęśliwy.wav")
const jab_7_audio = preload("res://src/assets/entities/log/sounds/Jabłonowski/Tym razem przesadził.wav")
const jab_8_audio = preload("res://src/assets/entities/log/sounds/Jabłonowski/Jest z nim gorzej.wav")

# this dict
# id: name - text - audio_to_play
# having them all here will make life easier
const logs: Dictionary = {
	LogId.dog_log: ["dog", "DOG", dog_audio],
	LogId.test_log: ["log_name", "log_text", test_audio],
	LogId.Jan_1:[
		"Ostatnie słowa",
		"Jan",
		"Coś tu jest nie tak, coś jest nie tak! Coś pojawiło się na statku... O Boże... idzie tu! To tu idzie! Aaaaaaa!!!",
		jan_1_audio
	],
	LogId.Jacek_1: [
		"Początek znajomości",
		"Szeregowy Jacek",
		"Warta w magazynie nie jest taka zła, dzięki niej mogę czasem porozmawiać z Robertem. Chciałbym kiedyś pomóc mu z eksperymentami, zamiast tylko siedzieć w różnych częściach statku.",
		jacek_1_audio
	],
	LogId.Robert_1: [
		"Po co to tu jest?",
		"Doktor Robert",
		"Augmented Unit... Nie rozumiem, po co to tu trzymamy... To tak jakby ludzie oczekiwali, że ta cała operacja nie wypali, a tak nie będzie! Ale jeśli już... to lepiej, żeby ten robot odzyskał wszystkie dane, moja praca nie może pójść na marnę!",
		robert_1_audio
	],
	LogId.Robert_2: [
		"Ci ludzie...",
		"Doktor Robert",
		"To niewiarygodne jak dużo trzeba gadać z tymi ludźmi, zanim cokolwiek dostanę z magazynu... Czy oni nie rozumieją, że w mojej pracy CZAS JEST KLUCZOWY?!",
		robert_2_audio
	],
	LogId.Jab_1: [
		"Podziw: bronie",
		"Admirał Jabłonowski",
		"Za każdym razem, gdy tu przychodzę, nie mogę się powstrzymać przed podziwianiem tej kolekcji broni... Ten statek to prawdziwe dzieło sztuki!",
		jab_1_audio
	],
	LogId.Jab_2: [
		"On musi z kimś porozmawiać",
		"Admirał Jabłonowski",
		"On oszalał! Wczoraj gadał jakieś głupoty, a teraz włamał się do zbrojowni! Może ktoś musi z nim porozmawiać...",
		jab_2_audio
	]
}

static func get_log_audio(log_id: LogId) -> AudioStream:
	var log_data = logs.get(log_id)
	if log_data:
		return log_data[2]
	return null

static func record_log_pickup(logId: LogId, manager: ProgressionManager) -> void:
	manager.record_log_pickup(logId)
