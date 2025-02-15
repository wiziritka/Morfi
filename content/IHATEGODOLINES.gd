extends LineEdit


func _on_editing_toggled(toggled_on: bool) -> void:
	if self.text == "": pass
	elif toggled_on == false and self.text[-1] != ".": self.text += "."
