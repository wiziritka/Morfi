extends Node

var check_button: Button

var task

var wordlist := {}
var alphabet: PackedStringArray = ["о","е","ё","а","и","н","т","с","р","в","ч",
"л","к","м","д","п","у","я","ы","ь","г","з","б","й","х","ж","ш",
"ю","ц","щ","э","ф","ъ","-"]
var questions: PackedStringArray = [
	"как",
	"дела",
	"кто","кого","кому","кем","ком",
	"что","чего","чему","чем","чём",
	"сколько","чей","который","где","когда","куда",
	"зачем","почему","отчего"
]
var null_forms: PackedStringArray = [
	"",
	"нет",
	"отс",
	"несущ",
	"невозм",
	"без"
]

#region Запись задания
# Чтение и импорт данных CSV
func import_resources_data():
	var file = FileAccess.open("res://wordlist/wordlist.csv",FileAccess.READ)
	while !file.eof_reached():
		var data_set = PackedStringArray(file.get_csv_line())
		wordlist[wordlist.size()] = data_set
	file.close()
	#print(wordlist) не имеет смысла, т.к. теперь вызывает output overflow.
	wordlist.erase(0) # Стирает массив с заголовками
	
# Определяет задание (случайный массив) из полученного словаря
func random_task() -> PackedStringArray:
	var task = wordlist.get(randi_range(1,wordlist.size() - 1), [])
	print(task)
	return task

# Определяет случайное задание по запросу
func pick_random_task_on_summon() -> PackedStringArray:
	import_resources_data()
	var summoned_task: PackedStringArray = random_task()
	print("^^^ SUMMONED TASK ^^^")
	return summoned_task
#endregion

#region Часто используемые

#endregion

#region Система проверки ответов
func input_normalizer(input: String) -> String:
	var exit_input: String = ""
	for i: String in input.to_lower():
		if i in alphabet:
			exit_input += i
	return exit_input

func is_variable_answer_correct(answer: String, comparable: String, 
	is_summoned_on_question = false, is_must_be_empty = false) -> bool:
	var answer_normalized: String = input_normalizer(answer)
	if is_must_be_empty:
		for null_form in null_forms:
			if answer_normalized.is_empty() or null_form in answer_normalized:
				return true 
		return false
	var cheating_score: int = -1
	if is_summoned_on_question:
		var answer_copy = answer_normalized
		for question_id in range(len(questions)):
			if cheating_score > 0: return false
			while questions[question_id] in answer_copy:
				cheating_score += 1
				answer_copy = answer_copy.erase(answer_copy.find(questions[question_id]), len(questions[question_id]))
				print("Cheating score: ", cheating_score, "; Iteration \"", answer_copy, "\"")
	if cheating_score < 1:
		for i in comparable.split(','):
			if i in answer_normalized: return true
			#answer.similarity(comparable) >= 80.0: return true
	return false
#endregion

#region Система декорации ответов
func make_correct(node: Control) -> void:
	node.theme = load("uid://bfuvhwr2aer5j")
	if node is Button: node.disabled = true
	if node is LineEdit: node.editable = false # Godot, ЗАЧЕМ?

func make_incorrect(node: Control,
correct_answer: String = "Правильный ответ не задан разработчиком") -> void:
	node.theme = load("uid://drlp23rj1afmb")
	if node is Button: node.disabled = true
	if node is LineEdit: node.editable = false
# TODO тут должна быть подстановка правильного ответа
# вместо неправильного, смена темы на жёлтую и + блокировка кнопки
# Можно попробовать сигналом принять по нажатию и менять.
#endregion

func func_of_shame(value) -> void:
	task = value
	check_button = get_node("/root/Morfi/MarginContainer/VBoxContainer2/AnswersCheck")
