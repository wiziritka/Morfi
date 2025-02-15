extends HFlowContainer

var pronoun_const_category: int = -1
var pronoun_const_person: int = -1
var pronoun_inconst_case: int = -1
var pronoun_inconst_number: int = -1
var pronoun_inconst_gend: int = -1

#region Функции каждой кнопки
func _on_category_pressed() -> void:
	pronoun_const_category += 1
	match pronoun_const_category:
		0:
			$Category.text = "личное"
			$Person.show()
			$LilSep.show()
		1:
			$Category.text = "возвратное"
			$Person.hide()
			$LilSep.hide()
			$Person.text = "лицо?"
			pronoun_const_person = -1
		2: $Category.text = "притяжательное" # исключения? WARNING
		3: $Category.text = "указательное"
		4: $Category.text = "определительное"
		5: $Category.text = "вопросительное"
		6: $Category.text = "относительное"
		7: $Category.text = "неопределённое"
		8: $Category.text = "отрицательное"
		_:
			$Category.text = "личное"; pronoun_const_category = 0
			$Person.show()
			$LilSep.show()


func _on_person_pressed() -> void:
	pronoun_const_person += 1
	match pronoun_const_person:
		0: $Person.text = "1-е лицо"
		1: $Person.text = "2-е лицо"
		2: $Person.text = "3-е лицо"
		_: $Person.text = "1-е лицо"; pronoun_const_person = 0


func _on_case_pressed() -> void:
	pronoun_inconst_case += 1
	match pronoun_inconst_case:
		0: $Case.text = "И.п."
		1: $Case.text = "Р.п."
		2: $Case.text = "Д.п."
		3: $Case.text = "В.п."
		4: $Case.text = "Т.п."
		5: $Case.text = "П.п."
		_: $Case.text = "И.п."; pronoun_inconst_case = 0


func _on_number_pressed() -> void:
	if pronoun_inconst_number != 0:
		pronoun_inconst_number = 0
		$Number.text = "ед.ч."
		$Gend.show()
		$LilSep3.show()
	else:
		pronoun_inconst_number = 1
		$Number.text = "мн.ч."
		$Gend.hide()
		$LilSep3.hide()


func _on_gend_pressed() -> void:
	pronoun_inconst_gend += 1
	match pronoun_inconst_gend:
		0: $Gend.text = "м.р."
		1: $Gend.text = "ж.р."
		2: $Gend.text = "ср.р."
		_: $Gend.text = "м.р."; pronoun_inconst_gend = 0
#endregion
