extends HFlowContainer

var adj_const_category: int = -1
var adj_inconst_form: int = -1
var adj_inconst_doc: int = -1
var adj_inconst_case: int = -1
var adj_inconst_number: int = -1
var adj_inconst_gend: int = -1

#region Функции каждой кнопки
func _on_category_pressed() -> void:
	adj_const_category += 1
	match adj_const_category:
		0:
			$Category.text = "качеств."
			$Form.show()
			$LilSep.show()
			$DoC.show()
			$LilSep2.show()
		1:
			$Category.text = "относит."
			$Form.hide()
			$LilSep.hide()
			$DoC.hide()
			$LilSep2.hide()
			$Case.show()
			$LilSep3.show()
		2:
			$Category.text = "притяж."
		_:
			$Category.text = "качеств."
			adj_const_category = 0
			$Form.show()
			$LilSep.show()
			$DoC.show()
			$LilSep2.show()
			if adj_inconst_form == 1:
				$Case.hide()
				$LilSep3.hide()

func _on_form_pressed() -> void:
	if adj_inconst_form != 0:
		adj_inconst_form = 0
		$Form.text = "полн.ф."
		$Case.show()
		$LilSep3.show()
	else:
		adj_inconst_form = 1
		$Form.text = "кр.ф."
		$Case.hide()
		$LilSep3.hide()


func _on_doc_pressed() -> void:
	if adj_inconst_doc != 0:
		adj_inconst_doc = 0
		$DoC.text = "сравнит."
	else:
		adj_inconst_doc = 1
		$DoC.text = "превосх."


func _on_case_pressed() -> void:
	adj_inconst_case += 1
	match adj_inconst_case:
		0: $Case.text = "И.п."
		1: $Case.text = "Р.п."
		2: $Case.text = "Д.п."
		3: $Case.text = "В.п."
		4: $Case.text = "Т.п."
		5: $Case.text = "П.п."
		_: $Case.text = "И.п."; adj_inconst_case = 0


func _on_number_pressed() -> void:
	if adj_inconst_number != 0:
		adj_inconst_number = 0
		$Number.text = "ед.ч."
		$Gend.show()
		$LilSep4.show()
	else:
		adj_inconst_number = 1
		$Number.text = "мн.ч."
		$Gend.hide()
		$LilSep4.hide()

func _on_gend_pressed() -> void:
	adj_inconst_gend += 1
	match adj_inconst_gend:
		0: $Gend.text = "м.р."
		1: $Gend.text = "ж.р."
		2: $Gend.text = "ср.р."
		_: $Gend.text = "м.р."; adj_inconst_gend = 0
#endregion
