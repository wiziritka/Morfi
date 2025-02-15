extends HFlowContainer

var pretext_compound: int = -1
var pretext_derivative: int = -1

#region Функции каждой кнопки
func _on_is_compound_pressed() -> void:
	if pretext_compound != 0:
		pretext_compound = 0
		$IsCompound.text = "простой"
	else:
		pretext_compound = 1
		$IsCompound.text = "составной"


func _on_derivative_pressed() -> void:
	if pretext_derivative != 0:
		pretext_derivative = 0
		$Derivative.text = "непроизв."
	else:
		pretext_derivative = 1
		$Derivative.text = "произв."
#endregion
