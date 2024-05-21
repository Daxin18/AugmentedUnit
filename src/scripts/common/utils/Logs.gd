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

const author_jan = "Jan"
const author_jacek = "Szeregowy Jacek"
const author_robert = "Doktor Robert"
const author_jab = "Admirał Jabłonowski"

# this dict
# id: name - text - audio_to_play
# having them all here will make life easier
const logs: Dictionary = {
	LogId.dog_log: ["dog", "DOG", dog_audio],
	LogId.test_log: ["log_name", "log_text", test_audio],
	LogId.Jan_1:[
		"Ostatnie słowa",
		author_jan,
		"Coś tu jest nie tak, coś jest nie tak! Coś pojawiło się na statku... O Boże... idzie tu! To tu idzie! Aaaaaaa!!!",
		jan_1_audio
	],
	LogId.Jacek_1: [
		"Początek znajomości",
		author_jacek,
		"Warta w magazynie nie jest taka zła, dzięki niej mogę czasem porozmawiać z Robertem. Chciałbym kiedyś pomóc mu z eksperymentami, zamiast tylko siedzieć w różnych częściach statku.",
		jacek_1_audio
	],
	LogId.Jacek_2: [
		"Na wszelki wypadek...",
		author_jacek,
		"Ok... Jacek... pamiętaj, łódź podwodna może być aktywowana TYLKO, jeśli alarm został już odpalony, a generator działa, pamiętaj, żeby wszystko przygotować, zanim coś zrobisz! Widziałeś, jak możesz skończyć!",
		jacek_2_audio
	],
	LogId.Jacek_3: [
		"Ostatnie życzenie",
		author_jacek,
		"To słowa pożegnalne... Jeśli ktoś czyta ten log, to znaczy, że znalazł go przy moim ciele i coś poszło nie tak... Proszę... upewnij się, że DEM zostanie zniszczony... To... to jest zbyt niebezpieczne, żeby ktokolwiek mógł tego używać...",
		jacek_3_audio
	],
	LogId.Jacek_4: [
		"Nazywa to DEM",
		author_jacek,
		"Ostatnio wypytywałem Roberta o tę jego maszynkę... broń? Nie ważne! Nazywa to DEM, skrót od Deus Ex Machina, mówi, że to dlatego, że to tak jakby na nowo wynalazł czas i przestrzeń... Muszę dowiedzieć się więcej!",
		jacek_4_audio
	],
	LogId.Jacek_5: [
		"W końcu jest ciekawie",
		author_jacek,
		"Robert... cały czas myli moje imię, ale całkiem przyjemnie się z nim pracuje. Można dużo się od niego dowiedzieć, a chociaż nie muszę nudzić się na statku. Chciałbym kiedyś zrobić coś przy DEM!",
		jacek_5_audio
	],
	LogId.Jacek_6: [
		"To było dziwne",
		author_jacek,
		" Walnąłem dziś DEM młotkiem, chciałem sprawdzić, czy naprawdę jest tak wytrzymałe, jak Robert mówił... Po uderzeniu poczułem się dziwnie, a Robert zaczął krzyczeć, że nie powinienem się do tego zbliżać bez ochrony i mówił coś o broni nuklearnej.",
		jacek_6_audio
	],
	LogId.Jacek_7: [
		"Nie czuję się najlepiej",
		author_jacek,
		"Moja głowa... Odkąd uderzyłem DEM, czuję się... dziwnie... jakbym nie był sobą, wszystko mi się miesza, wszystko wydaje się obce, ten statek nie jest już taki, jak pamiętałem!",
		jacek_7_audio
	],
	LogId.Jacek_8: [
		"Trzeba go ostrzec!",
		author_jacek,
		"Nie mam już wstępu do laboratorium... Chciałem tylko pójść porozmawiać z Robertem... Widziałem dziwne rzeczy, DEM nie jest bezpieczny, nie powinniśmy dalej nad tym pracować!",
		jacek_8_audio
	],
	LogId.Jacek_9: [
		"Nie mogę tak dłużej",
		author_jacek,
		"Robert nie zaniepokoił się tym, co mu powiedziałem... Tylko bardziej go to zmotywowało do prowadzenia prac nad DEM! Nie można dłużej tego ciągnąć! Muszę wziąć się w garść i zniszczyć to, zanim będzie za późno!",
		jacek_9_audio
	],
	LogId.Robert_1: [
		"Po co to tu jest?",
		author_robert,
		"Augmented Unit... Nie rozumiem, po co to tu trzymamy... To tak jakby ludzie oczekiwali, że ta cała operacja nie wypali, a tak nie będzie! Ale jeśli już... to lepiej, żeby ten robot odzyskał wszystkie dane, moja praca nie może pójść na marnę!",
		robert_1_audio
	],
	LogId.Robert_2: [
		"Ci ludzie...",
		author_robert,
		"To niewiarygodne jak dużo trzeba gadać z tymi ludźmi, zanim cokolwiek dostanę z magazynu... Czy oni nie rozumieją, że w mojej pracy CZAS JEST KLUCZOWY?!",
		robert_2_audio
	],
	LogId.Robert_3: [
		"Dlaczego statek?",
		author_robert,
		"Czasami ludzie pytają się — czemu akurat statek? Czemu nie pracujesz na lądzie, czy w jakimś bunkrze? Odchodzę wtedy bez słowa... Oni nie potrafią pojąć, że pływając, dużo prościej jest pojąć naturę mojej pracy. Zrozumieć fenomen, który jest z nami non-stop, a którego nie dostrzegamy!",
		robert_3_audio
	],
	LogId.Robert_4: [
		"Ten szeregowy...",
		author_robert,
		"Ten szeregowy, jak on miał... Janek? Nie ważne! Ostatnio zaczął się sporo koło mnie kręcić, podpytuje o postęp prac, próbuje dowiedzieć się czegoś o DEM... Zabiera mi tylko czas! Chociaż... Wydaje się faktycznie zainteresowany, może się jeszcze do czegoś przydać.",
		robert_4_audio
	],
	LogId.Robert_5: [
		"Zaczynam się do niego przekonywać...",
		author_robert,
		"Ten Janek zdaje się być coraz bardziej zainteresowany moimi badaniami... Kręci się przy laboratorium, dopytuje, przygląda się DEM, gdy jesteśmy w laboratorium... Powoli zaczynam się do niego przekonywać... może być dobrym pomocnikiem",
		robert_5_audio
	],
	LogId.Robert_6: [
		"Jest bystry... ale nadal głupi",
		author_robert,
		"Z każdym dniem Janek zadziwia mnie coraz bardziej! Dzisiaj próbował dotknąć DEM __GOŁYMI RĘKAMI__! Wie przecież, że DEM nie jest jeszcze stabilny... potem chciał sprawdzić, co się stanie, gdy spróbuje uderzyć to młotkiem! Powiedziałem mu, że jeśli chce cokolwiek zrobić tej broni, to potrzebowałby broni nuklearnej, a nie młotka!",
		robert_6_audio
	],
	LogId.Robert_7: [
		"Za kogo on się uważa?!",
		author_robert,
		"Za kogo on się uważa?! Ten Admirał twierdzi, że Janek ma problemy przeze mnie! Sam uderzył młotkiem w DEM, nie słuchał moich ostrzeżeń i to on sobie coś zrobił... Wróci do siebie za dzień czy dwa i powinien dalej mi pomagać, nic mu się nie stanie, jeśli będzie się słuchał!",
		robert_7_audio
	],
	LogId.Robert_8: [
		"Muszę to zbadać",
		author_robert,
		"Udało mi się dzisiaj porozmawiać krótko z Jankiem w kajutach... Mówił o DEM, o tym, że od wypadku widzi dziwne rzeczy... Czy to możliwe, że DEM zaczyna działać, jak powinien? Muszę to sprawdzić!",
		robert_8_audio
	],
	LogId.Jab_1: [
		"Podziw: bronie",
		author_jab,
		"Za każdym razem, gdy tu przychodzę, nie mogę się powstrzymać przed podziwianiem tej kolekcji broni... Ten statek to prawdziwe dzieło sztuki!",
		jab_1_audio
	],
	LogId.Jab_2: [
		"On musi z kimś porozmawiać",
		author_jab,
		"On oszalał! Wczoraj gadał jakieś głupoty, a teraz włamał się do zbrojowni! Może ktoś musi z nim porozmawiać...",
		jab_2_audio
	],
	LogId.Jab_3: [
		"Podziw: łódź podwodna",
		author_jab,
		"Ta łódź... to najcudowniejsza defensywna technologia na tym statku... ponoć może nawet przetrwać wybuch nuklearny!",
		jab_3_audio
	],
	LogId.Jab_4: [
		"Zrobiłem to...",
		author_jab,
		"Zrobiłem to... Ja... Już go nie ma... I nikt nie wie... Tyl... Tylko ja mam dostęp do zbrojowni i... ja... zostawiłem go tam... Boże! [płacz]",
		jab_4_audio
	],
	LogId.Jab_5: [
		"Waga naszej misji",
		author_jab,
		"Nasza misja jest ważna... to miejsce mi o tym przypomina... Jeden błąd, jeden atak i cały statek musi zostać wysadzony w powietrze! Tylko Admirał ma dostęp do tego pokoju, tylko Admirał ma kody... Tylko ja decyduję, co się stanie na wypadek ataku...",
		jab_5_audio
	],
	LogId.Jab_6: [
		"Cieszę się, że jest szczęśliwy",
		author_jab,
		"Jacek ostatnio spędza bardzo dużo czasu z Robertem, cieszę się, że w końcu ma co robić, widać było, że nie przepada za wartami, a w ten sposób może chociaż uda im się skończyć te badania szybciej.",
		jab_6_audio
	],
	LogId.Jab_7: [
		"Tym razem przesadził",
		author_jab,
		"Właśnie wróciłem z rozmowy z Robertem! Po ostatnim incydencie w laboratorium Jacek dziwnie się zachowuje... Zabroniłem mu już tam eksperymentować i dałem kilka dni na dojście do siebie, a Robert będzie już dużo dokładniej kontrolowany!",
		jab_7_audio
	],
	LogId.Jab_8: [
		"Jest z nim gorzej",
		author_jab,
		"Z Jackiem jest coraz gorzej! Usilnie próbuje dostać się do laboratorium, żeby porozmawiać z Robertem... A on cały czas tylko tam siedzi, jakby ostatni wypadek tylko bardziej go zmotywował...",
		jab_8_audio
	]
}

static func get_log_audio(log_id: LogId) -> AudioStream:
	var log_data = logs.get(log_id)
	if log_data:
		return log_data[3]
	return null

static func get_log_title(log_id: LogId) -> String:
	var log_data = logs.get(log_id)
	if log_data:
		return log_data[0]
	return "LogTitleNotFound"

static func get_log_author(log_id: LogId) -> String:
	var log_data = logs.get(log_id)
	if log_data:
		return log_data[1]
	return "LogAuthorNotFound"

static func get_log_text(log_id: LogId) -> String:
	var log_data = logs.get(log_id)
	if log_data:
		return log_data[2]
	return "LogTextNotFound"

static func record_log_pickup(logId: LogId, manager: ProgressionManager) -> void:
	manager.record_log_pickup(logId)
