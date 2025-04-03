extends HFlowContainer

var f_particle: int = -1

func _on_category_pressed() -> void:
	if f_particle != 0:
		f_particle = 0
		$Category.text = "формообразующая"
	else:
		f_particle = 1
		$Category.text = "модальная"
#region Проверка ответов
func _ready() -> void:	
	Global.check_button.pressed.connect(checks)

func checks() -> void:
	if $Category.text == Global.task[13]:
		Global.make_correct($Category)
	else: Global.make_incorrect($Category)
#endregion
