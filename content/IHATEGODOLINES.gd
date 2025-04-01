extends LineEdit


func _on_editing_toggled(toggled_on: bool) -> void:
	if text.is_empty(): return
	if not toggled_on and text[-1] != ".":
		text += "."
