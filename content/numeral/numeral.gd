extends HFlowContainer

var num_const_type: int = -1
var num_const_compound: int = -1
var num_const_category: int = -1
var num_inconst_case: int = -1
var num_inconst_number: int = -1
var num_inconst_gend: int = -1

#region Функции каждой кнопки
func _on_is_compound_pressed() -> void:
	if num_const_compound != 0:
		num_const_compound = 0
		$IsCompound.text = "простое"
	else:
		num_const_compound = 1
		$IsCompound.text = "составное"


func _on_type_pressed() -> void:
	if num_const_type != 0:
		num_const_type = 0
		$Type.text = "количеств."
		$Category.show()
		$LilSep2.show()
	else:
		num_const_type = 1
		$Type.text = "порядков."
		$Category.hide()
		$LilSep2.hide()
		num_const_category = -1
		$Category.text = "разряд?"


func _on_category_pressed() -> void:
	num_const_category += 1
	match num_const_category:
		0: $Category.text = "целое"
		1: $Category.text = "дробное"
		2: $Category.text = "собирательное"
		_: $Category.text = "целое"; num_const_category = 0


func _on_case_pressed() -> void:
	num_inconst_case += 1
	match num_inconst_case:
		0: $Case.text = "И.п."
		1: $Case.text = "Р.п."
		2: $Case.text = "Д.п."
		3: $Case.text = "В.п."
		4: $Case.text = "Т.п."
		5: $Case.text = "П.п."
		_: $Case.text = "И.п."; num_inconst_case = 0


func _on_number_pressed() -> void:
	if num_inconst_number != 0:
		num_inconst_number = 0
		$Number.text = "ед.ч."
		$Gend.show()
		$LilSep4.show()
	else:
		num_inconst_number = 1
		$Number.text = "мн.ч."
		$Gend.hide()
		$LilSep4.hide()


func _on_gend_pressed() -> void:
	num_inconst_gend += 1
	match num_inconst_gend:
		0: $Gend.text = "нет рода"
		1: $Gend.text = "м.р."
		2: $Gend.text = "ж.р."
		3: $Gend.text = "ср.р."
		_: $Gend.text = "м.р."; num_inconst_gend = 0
#endregion

#region Проверка ответов
func _ready() -> void:	
	Global.check_button.pressed.connect(checks)

func checks() -> void:
	if $IsCompound.text == Global.task[23]:
		Global.make_correct($IsCompound)
	else: Global.make_incorrect($IsCompound)
	if $Type.text == Global.task[16]:
		Global.make_correct($Type)
	else: Global.make_incorrect($Type)
	if $Category.text == Global.task[13]:
		Global.make_correct($Category)
	else: Global.make_incorrect($Category)
	if $Case.text == Global.task[12]:
		Global.make_correct($Case)
	else: Global.make_incorrect($Case)
	if $Number.text == Global.task[11]:
		Global.make_correct($Number)
	else: Global.make_incorrect($Number)
	if $Gend.text == Global.task[9]:
		Global.make_correct($Gend)
	else: Global.make_incorrect($Gend)
#endregion
