extends HFlowContainer

var prpl_const_passive = -1
var prpl_const_tense = -1
var prpl_const_type = -1
var prpl_const_reflexive = -1
var prpl_inconst_form = -1
var prpl_inconst_case = -1
var prpl_inconst_number = -1
var prpl_inconst_gend = -1

#region Функции каждой кнопки
func _on_active_pressed() -> void:
	if prpl_const_passive != 0:
		prpl_const_passive = 0
		$Active.text = "действ."
	else:
		prpl_const_passive = 1
		$Active.text = "страдат."


func _on_tense_pressed() -> void:
	if prpl_const_tense != 0:
		prpl_const_tense = 0
		$Tense.text = "прош. вр."
	else:
		prpl_const_tense = 1
		$Tense.text = "наст. вр."


func _on_type_pressed() -> void:
	if prpl_const_type != 0:
		prpl_const_type = 0
		$Type.text = "несов."
	else:
		prpl_const_type = 1
		$Type.text = "соверш."


func _on_reflexive_pressed() -> void:
	if prpl_const_reflexive != 0:
		prpl_const_reflexive = 0
		$Reflexive.text = "возвр."
	else:
		prpl_const_reflexive = 1
		$Reflexive.text = "невозвр."


func _on_form_pressed() -> void:
	if prpl_inconst_form != 0:
		prpl_inconst_form = 0
		$Form.text = "полн.ф."
		$Case.show()
		$LilSep5.show()
	else:
		prpl_inconst_form = 1
		$Form.text = "кр.ф."
		$Case.hide()
		$LilSep5.hide()


func _on_case_pressed() -> void:
	prpl_inconst_case += 1
	match prpl_inconst_case:
		0: $Case.text = "И.п."
		1: $Case.text = "Р.п."
		2: $Case.text = "Д.п."
		3: $Case.text = "В.п."
		4: $Case.text = "Т.п."
		5: $Case.text = "П.п."
		_: $Case.text = "И.п."; prpl_inconst_case = 0


func _on_number_pressed() -> void:
	if prpl_inconst_number != 0:
		prpl_inconst_number = 0
		$Number.text = "ед.ч."
		$Gend.show()
		$LilSep6.show()
	else:
		prpl_inconst_number = 1
		$Number.text = "мн.ч."
		$Gend.hide()
		$LilSep6.hide()


func _on_gend_pressed() -> void:
	prpl_inconst_gend += 1
	match prpl_inconst_gend:
		0: $Gend.text = "м.р."
		1: $Gend.text = "ж.р."
		2: $Gend.text = "ср.р."
		_: $Gend.text = "м.р."; prpl_inconst_gend = 0
#endregion
