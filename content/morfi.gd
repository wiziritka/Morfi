extends Control

var task: PackedStringArray = Global.pick_random_task_on_summon()
var is_second_loaded := false
var is_need_to_reload := true
var morfi_scene: PackedScene = preload("res://content/morfi.tscn")

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
const ROLES: PackedStringArray = [
	"подлежащее.", 
	"сказуемое.", 
	"определение.",
	"обстоятельство.",
	"дополнение.", 
	"служебная часть речи / нет.",
	":)"
]
#endregion

#region Правильные ответы
var kword: String = task[0]
var author: String = task[1]
var ktype: String = task[2]
var ktext: String = task[3]
var kq: String = task[4]
var kform: String = task[5]
var krole: String = task[6]

var is_q_must_be_empty := false
var is_f_must_be_empty := false
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
	
	if krole == ROLES[-1] or ktype == TYPES[5][0]: is_f_must_be_empty = true
	if krole == ROLES[-1]: is_q_must_be_empty = true
	
	Global.func_of_shame(task)

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
func _on_key_form_text_changed(new_text: String) -> void:
	cform = new_text

func _on_role_pressed() -> void:
	crole = (crole + 1) % 6
	$MarginContainer/VBoxContainer/Features/Role.text = ROLES[crole]

func _on_copy_text_pressed() -> void:
	var clipboard_content: String = ktext + " [" + author + "]"
	DisplayServer.clipboard_set(clipboard_content)

func _on_answers_check_pressed() -> void:
	# ВОПРОС
	if Global.is_variable_answer_correct(cq, kq, true, is_q_must_be_empty):
		Global.make_correct($MarginContainer/VBoxContainer/Features/First/Question)
		Global.make_correct($MarginContainer/VBoxContainer/Features/Third/Question)
	else:
		Global.make_incorrect($MarginContainer/VBoxContainer/Features/First/Question)
		Global.make_incorrect($MarginContainer/VBoxContainer/Features/Third/Question)
	# НАЧАЛЬНАЯ ФОРМА
	if Global.is_variable_answer_correct(cform, kform, false, is_f_must_be_empty):
		Global.make_correct($MarginContainer/VBoxContainer/Features/First/KeyForm)
	else:
		Global.make_incorrect($MarginContainer/VBoxContainer/Features/First/KeyForm)
	# РОЛЬ
	if ROLES[crole] == krole:
		Global.make_correct($MarginContainer/VBoxContainer/Features/Role)
	else:
		Global.make_incorrect($MarginContainer/VBoxContainer/Features/Role)
	# ТИП
	if ctype == ktype:
		Global.make_correct($MarginContainer/VBoxContainer/WordInfo/OptionButton)
	else:
		Global.make_incorrect($MarginContainer/VBoxContainer/WordInfo/OptionButton)
		
	$MarginContainer/VBoxContainer2/AnswersCheck.text = "Следующее упражнение"
	is_need_to_reload = not is_need_to_reload
	if is_need_to_reload:
		get_tree().change_scene_to_packed(morfi_scene)
#endregion
