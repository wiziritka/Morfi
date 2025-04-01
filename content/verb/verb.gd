extends HFlowContainer

var verb_const_type: int = -1
var verb_const_reflexive: int = -1
var verb_const_transitivity: int = -1
var verb_const_conjugation: int = -1
var verb_inconst_mood: int = -1
var verb_inconst_tense: int = -1
var verb_inconst_person: int = -1
var verb_inconst_number: int = -1
var verb_inconst_gend: int = -1

#region Функции каждой кнопки
func _on_type_pressed() -> void:
	if verb_const_type != 0:
		verb_const_type = 0
		$Type.text = "несов."
	else:
		verb_const_type = 1
		$Type.text = "соверш."


func _on_reflexive_pressed() -> void:
	if verb_const_reflexive != 0:
		verb_const_reflexive = 0
		$Reflexive.text = "возвр."
	else:
		verb_const_reflexive = 1
		$Reflexive.text = "невозвр."

func _on_transitivity_pressed() -> void:
	if verb_const_transitivity != 0:
		verb_const_transitivity = 0
		$Transitivity.text = "перех."
	else:
		verb_const_transitivity = 1
		$Transitivity.text = "неперех."


func _on_conjugation_pressed() -> void:
	if verb_const_conjugation != 0:
		verb_const_conjugation = 0
		$Conjugation.text = "I спр."
	else:
		verb_const_conjugation = 1
		$Conjugation.text = "II спр." # Добавить "неопр."


func _on_mood_pressed() -> void:
	verb_inconst_mood += 1
	match verb_inconst_mood:
		0: $Mood.text = "изъявит."
		1: $Mood.text = "усл."
		2: $Mood.text = "повелит."
		_: $Mood.text = "изъявит."; verb_inconst_mood = 0

func _on_tense_pressed() -> void:
	verb_inconst_tense += 1
	match verb_inconst_tense:
		0: $Tense.text = "прош. вр."
		1: $Tense.text = "наст. вр."
		2: $Tense.text = "буд. вр."
		3: $Tense.text = "н.ф." # ЗАМЕНИТЬ НА инф.
		_: $Tense.text = "прош. вр."; verb_inconst_tense = 0


func _on_person_pressed() -> void:
	verb_inconst_person += 1
	match verb_inconst_person:
		0: $Person.text = "1-е лицо"
		1: $Person.text = "2-е лицо"
		2: $Person.text = "3-е лицо"
		3: $Person.text = "безличн."
		_: $Person.text = "1-е лицо"; verb_inconst_person = 0


func _on_number_pressed() -> void:
	if verb_inconst_number != 0:
		verb_inconst_number = 0
		$Number.text = "ед.ч."
		$Gend.show()
		$LilSep7.show()
	else:
		verb_inconst_number = 1
		$Number.text = "мн.ч."
		$Gend.hide()
		$LilSep7.hide()


func _on_gend_pressed() -> void:
	verb_inconst_gend += 1
	match verb_inconst_gend:
		0: $Gend.text = "м.р."
		1: $Gend.text = "ж.р."
		2: $Gend.text = "ср.р."
		_: $Gend.text = "м.р."; verb_inconst_gend = 0
#endregion
