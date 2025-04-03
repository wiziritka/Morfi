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

#region Проверка ответов
func _ready() -> void:	
	Global.check_button.pressed.connect(checks)

func checks() -> void:
	if $Category.text == Global.task[13]:
		Global.make_correct($Category)
	else: Global.make_incorrect($Category)
#endregion
