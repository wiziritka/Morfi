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
	noun_inconst_case += 1
	match noun_inconst_case:
		0: $Case.text = "И.п."
		1: $Case.text = "Р.п."
		2: $Case.text = "Д.п."
		3: $Case.text = "В.п."
		4: $Case.text = "Т.п."
		5: $Case.text = "П.п."
		_: $Case.text = "И.п."; noun_inconst_case = 0
#endregion

#region Проверка ответов
func _ready() -> void:	
	Global.check_button.pressed.connect(checks)

func checks() -> void:
	if $Name.text == Global.task[7]:
		Global.make_correct($Name)
	else: Global.make_incorrect($Name)
	if $Soul.text == Global.task[8]:
		Global.make_correct($Soul)
	else: Global.make_incorrect($Soul)
	if $Gend.text == Global.task[9]:
		Global.make_correct($Gend)
	else: Global.make_incorrect($Gend)
	if $Declension.text == Global.task[10]:
		Global.make_correct($Declension)
	else: Global.make_incorrect($Declension)
	if $Number.text == Global.task[11]:
		Global.make_correct($Number)
	else: Global.make_incorrect($Number)
	if $Case.text == Global.task[12]:
		Global.make_correct($Case)
	else: Global.make_incorrect($Case)
#endregion
