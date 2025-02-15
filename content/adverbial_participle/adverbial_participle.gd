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
