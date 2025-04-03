extends HFlowContainer

var advp_type: int = -1
var advp_reflexive: int = -1

#region Функции каждой кнопки
func _on_type_pressed() -> void:
	if advp_type != 0:
		advp_type = 0
		$Type.text = "несов."
	else:
		advp_type = 1
		$Type.text = "соверш."


func _on_reflexive_pressed() -> void:
	if advp_reflexive != 0:
		advp_reflexive = 0
		$Reflexive.text = "возвр."
	else:
		advp_reflexive = 1
		$Reflexive.text = "невозвр."
#endregion

#region Проверка ответов
func _ready() -> void:	
	Global.check_button.pressed.connect(checks)

func checks() -> void:
	if $Type.text == Global.task[16]:
		Global.make_correct($Type)
	else: Global.make_incorrect($Type)
	if $Reflexive.text == Global.task[17]:
		Global.make_correct($Reflexive)
	else: Global.make_incorrect($Reflexive)
#endregion
