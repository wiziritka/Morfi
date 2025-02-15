extends HFlowContainer

var noun_const_name: int = -1
var noun_const_soul: int = -1
var noun_const_gend: int = -1
var noun_const_declension: int = -1
var noun_inconst_number: int = -1
var noun_inconst_case: int = -1

#region Функции каждой кнопки
func _on_name_pressed() -> void:
	if noun_const_name != 0:
		noun_const_name = 0
		$Name.text = "нариц."
	else:
		noun_const_name = 1
		$Name.text = "собств."

func _on_soul_pressed() -> void:
	if noun_const_soul != 0:
		noun_const_soul = 0
		$Soul.text = "неодуш."
	else:
		noun_const_soul = 1
		$Soul.text = "одуш."


func _on_gend_pressed() -> void:
	noun_const_gend += 1
	match noun_const_gend:
		0: $Gend.text = "м.р."
		1: $Gend.text = "ж.р."
		2: $Gend.text = "ср.р."
		_: $Gend.text = "м.р."; noun_const_gend = 0


func _on_declension_pressed() -> void:
	noun_const_declension += 1
	match noun_const_declension:
		0: $Declension.text = "1 скл."
		1: $Declension.text = "2 скл."
		2: $Declension.text = "3 скл."
		3: $Declension.text = "нескл."
		_: $Declension.text = "1 скл."; noun_const_declension = 0

func _on_number_pressed() -> void:
	if noun_inconst_number != 0:
		noun_inconst_number = 0
		$Number.text = "ед.ч."
		$Gend.show()
		$LilSep3.show()
	else:
		noun_inconst_number = 1
		$Number.text = "мн.ч."
		$Gend.hide()
		$LilSep3.hide()


func _on_case_pressed() -> void:
	noun_inconst_case = Global.change_case(noun_inconst_case, $Case)
#endregion
