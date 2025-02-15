extends HFlowContainer

var f_particle: int = -1


func _on_category_pressed() -> void:
		if f_particle != 0:
			f_particle = 0
			$Category.text = "формообразующая"
		else:
			f_particle = 1
			$Category.text = "модальная"
