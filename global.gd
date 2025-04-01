extends Node
# Это глобальный класс!
var test_var
var wordlist := {}
var alphabet: PackedStringArray = ["о","е","ё","а","и","н","т","с","р","в","ч",
"л","к","м","д","п","у","я","ы","ь","г","з","б","й","х","ж","ш",
"ю","ц","щ","э","ф","ъ"]

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

func is_variable_answer_correct(answer: String, comparable: String) -> bool:
	#comparable = 'которыйпосч,что'
	var answer_normalized: String = input_normalizer(answer)
	#print(answer_normalized)
	if answer_normalized in comparable or \
	answer.similarity(comparable) >= 80.0: return true # DANGER
	else: return false
#endregion
