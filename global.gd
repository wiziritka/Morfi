extends Node
# Это глобальный класс!
var test_var
var wordlist := {}

#region Запись задания
# Чтение и импорт данных CSV
func import_resources_data():
	var file = FileAccess.open("res://wordlist/wordlist.csv",FileAccess.READ)
	while !file.eof_reached():
		var data_set = Array(file.get_csv_line())
		wordlist[wordlist.size()] = data_set
	file.close()
	print(wordlist)
	wordlist.erase(0) # Стирает массив с заголовками
	
# Определяет задание (случайный массив) из полученного словаря
func random_task() -> Array:
	var task = wordlist.get(randi_range(1,wordlist.size() - 1), [])
	print(task)
	return task

# Определяет случайное задание по запросу
func pick_random_task_on_summon() -> Array:
	import_resources_data()
	var summoned_task: Array = random_task()
	print("^^^ SUMMONED TASK ^^^")
	return summoned_task
#endregion

#region Часто используемые
func change_case(case_var: int, case_node: Button):
	case_var += 1
	match case_var:
		0: case_node.text = "И.п."
		1: case_node.text = "Р.п."
		2: case_node.text = "Д.п."
		3: case_node.text = "В.п."
		4: case_node.text = "Т.п."
		5: case_node.text = "П.п."
		_: case_node.text = "И.п."; case_var = 0
	return case_var
#endregion
