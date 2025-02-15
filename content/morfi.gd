extends Control

var task: Array = Global.pick_random_task_on_summon()
var is_second_loaded := false
var current_role: int = 0

#region Правильные ответы
var kword: String = task[0]
var ktype: String = task[2]
var ktext: String = task[3]
var kq: String = task[4]
var kform: String = task[5]
var krole: String = task[6]
var ksec: Array = task.slice(7)

#endregion

func _ready():
	$MarginContainer/VBoxContainer/WordInfo/OptionButton.text = "часть речи?"
	replace_base_values() # Подставляем First и Third пункты, а также заголовок

#region Подстановка основных значений
func replace_base_values():
	$MarginContainer/VBoxContainer/Label.text = ktext
	$MarginContainer/VBoxContainer/WordInfo/KeyWord.text = kword
	$MarginContainer/VBoxContainer/Features/First/KeyWord.text = kword
	$MarginContainer/VBoxContainer/Features/Third/KeyWord.text = kword
#endregion

#region Переключатель Second пункта для разных частей речи
func _on_option_button_item_selected(index: int) -> void:
	switcher(index)

func switcher(selected_type: int):
	match selected_type:
		0: load_from("uid://bpmwbl37jfu2x") # Существительное ALERT
		1: load_from("uid://kqjkbveh01nv") # Прилагательное ALERT
		2: load_from("uid://bxaqydcdovra3") # Глагол ALERT
		3: load_from("uid://c2se8qdf2y4ub") # Числительное ALERT
		4: load_from("uid://bwjpiegpghfhp") # Причастие ALERT
		5: load_from("uid://b5qhcem6ro143") # Деепричастие ALERT
		6: load_from("uid://0thxo47sdfuj") # Наречие ALERT
		7: load_from("uid://cos1xibhmi6b8") # Местоимение ALERT
		8: load_from("uid://c57wgwkq56w0k") # Предлог ALERT
		9: load_from("uid://bbpjlyw6b7i1q") # Союз ALERT
		10: load_from("uid://blwr56aflhx23")  # Частица ALERT
		_: print("ERR: switcher() out of range") # На будущее при расширении

func load_from(scenestr: String):
	if is_second_loaded == true:
		var delcandidate = $MarginContainer/VBoxContainer/Features/Second
		delcandidate.get_parent().remove_child(delcandidate)
		delcandidate.queue_free()
	var scene = load(scenestr)
	var node = scene.instantiate()
	node.name = "Second"
	$MarginContainer/VBoxContainer/Features.add_child(node)
	$MarginContainer/VBoxContainer/Features.move_child(node, -3)
	is_second_loaded = true
#endregion

#region Попарная работа полей с вопросом
func _on_first_question_text_changed(new_text: String) -> void:
	$MarginContainer/VBoxContainer/Features/Third/Question.text = new_text
func _on_third_question_text_changed(new_text: String) -> void:
	$MarginContainer/VBoxContainer/Features/First/Question.text = new_text
#endregion

#region Переключение значений First и Third пользователем.
func _on_role_pressed() -> void:
	current_role += 1
	var role_node = $MarginContainer/VBoxContainer/Features/Role
	match current_role:
		1: role_node.text = "подлежащее."
		2: role_node.text = "сказуемое."
		3: role_node.text = "обстоятельство."
		4: role_node.text = "определение."
		5: role_node.text = "дополнение"
		6: role_node.text = "служебная часть речи / нет."
		7: 
			current_role = 1
			role_node.text = "подлежащее."
		_: print("ERR: _on_role_pressed() out of range")
#endregion
