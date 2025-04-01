extends Control

var task: PackedStringArray = Global.pick_random_task_on_summon()
var is_second_loaded := false

#region Массивы строк
const TYPES: Array[Array] = [
	["Существительное", "uid://bpmwbl37jfu2x"],
	["Прилагательное", "uid://kqjkbveh01nv"],
	["Глагол", "uid://bxaqydcdovra3"],
	["Числительное", "uid://c2se8qdf2y4ub"],
	["Причастие", "uid://bwjpiegpghfhp"],
	["Деепричастие", "uid://b5qhcem6ro143"],
	["Наречие", "uid://0thxo47sdfuj"],
	["Местоимение", "uid://cos1xibhmi6b8"],
	["Предлог", "uid://c57wgwkq56w0k"],
	["Союз", "uid://bbpjlyw6b7i1q"],
	["Частица", "uid://blwr56aflhx23"]
]
const ROLES: PackedStringArray = ["подлежащее.", "сказуемое.", "обстоятельство.",
"дополнение.", "служебная часть речи / нет."]
#endregion

#region Правильные ответы
var kword: String = task[0]
var author: String = task[1]
var ktype: String = task[2]
var ktext: String = task[3]
var kq: String = task[4]
var kform: String = task[5]
var krole: String = task[6]
var ksec: Array = task.slice(7)
#endregion

#region Ввод пользователя
var ctype: String = ""
var cq: String = ""
var cform: String = ""
var crole: int = -1
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
	load_from(TYPES[index][1])
	ctype = TYPES[index][0]

func load_from(scene_path: String):
	if is_second_loaded:
		var delcandidate = $MarginContainer/VBoxContainer/Features/Second
		delcandidate.get_parent().remove_child(delcandidate)
		delcandidate.queue_free()
	var scene = load(scene_path)
	var node = scene.instantiate()
	node.name = "Second"
	$MarginContainer/VBoxContainer/Features.add_child(node)
	$MarginContainer/VBoxContainer/Features.move_child(node, -3)
	is_second_loaded = true
#endregion

#region Попарная работа полей с вопросом
func _on_first_question_text_changed(new_text: String) -> void:
	$MarginContainer/VBoxContainer/Features/Third/Question.text = new_text
	cq = new_text
func _on_third_question_text_changed(new_text: String) -> void:
	$MarginContainer/VBoxContainer/Features/First/Question.text = new_text
	cq = new_text
#endregion

#region Кнопки / Сигналы
func _on_role_pressed() -> void:
	crole = (crole + 1) % 5
	$MarginContainer/VBoxContainer/Features/Role.text = ROLES[crole] + "."

func _on_copy_text_pressed() -> void:
	var clipboard_content: String = ktext + " [" + author + "]"
	DisplayServer.clipboard_set(clipboard_content)

func _on_answers_check_pressed() -> void:
	# ВОПРОС
	if Global.is_variable_answer_correct(cq,kq):
		make_correct($MarginContainer/VBoxContainer/Features/First/Question)
		make_correct($MarginContainer/VBoxContainer/Features/Third/Question)
	else:
		make_incorrect($MarginContainer/VBoxContainer/Features/First/Question)
		make_incorrect($MarginContainer/VBoxContainer/Features/Third/Question)
	# НАЧАЛЬНАЯ ФОРМА
	if Global.is_variable_answer_correct(cform, kform):
		make_correct($MarginContainer/VBoxContainer/Features/First/KeyForm)
	else:
		make_incorrect($MarginContainer/VBoxContainer/Features/First/KeyForm)
	# РОЛЬ
	if ROLES[crole] == krole:
		make_correct($MarginContainer/VBoxContainer/Features/Role)
	else:
		make_incorrect($MarginContainer/VBoxContainer/Features/Role)
	# ТИП
	if ctype == ktype:
		make_correct($MarginContainer/VBoxContainer/WordInfo/OptionButton)
	else:
		make_incorrect($MarginContainer/VBoxContainer/WordInfo/OptionButton)
#endregion

#region Система проверки ответов
func make_correct(node: Control) -> void:
	node.theme = load("uid://bfuvhwr2aer5j")
	if node is Button: node.disabled = true
	if node is LineEdit: node.editable = false # Godot, ЗАЧЕМ?

func make_incorrect(node: Control,
correct_answer: String = "Правильный ответ не задан разработчиком") -> void:
	node.theme = load("uid://drlp23rj1afmb")
	if node is Button: node.disabled = true
	if node is LineEdit: node.editable = false
	if correct_answer == '': pass
# TODO тут должна быть подстановка правильного ответа
# вместо неправильного, смена темы на жёлтую и + блокировка кнопки
# Можно попробовать сигналом принять по нажатию и менять.
#endregion
