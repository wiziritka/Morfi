extends HFlowContainer

var adv_category: int = -1
var adv_doc: int = -1

#region Функции каждой кнопки
func _on_category_pressed() -> void:
	adv_category += 1
	match adv_category:
		0: $Category.text = "времени"
		1: $Category.text = "места"
		2: $Category.text = "причины"
		3: $Category.text = "цели"
		4: $Category.text = "меры/степени"
		5: $Category.text = "образа"
		_: $Category.text = "времени"; adv_category = 0


func _on_doc_pressed() -> void:
	adv_doc += 1
	match adv_doc:
		0: $DoC.text = "сравнит."
		1: $DoC.text = "превосх."
		2: $DoC.text = "ст. сравн. отс."
		_: $DoC.text = "сравнит."; adv_doc = 0
#endregion
