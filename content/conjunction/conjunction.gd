extends HFlowContainer

var conj_compound: int = -1
var conj_category: int = -1
var conj_postcategory: int = -1

#region Функции каждой кнопки
func _on_is_compound_pressed() -> void:
	conj_compound += 1
	match conj_compound:
		0: $IsCompound.text = "простой"
		1: $IsCompound.text = "сложный"
		_: $IsCompound.text = "простой"; conj_compound = 0 

func _on_meaning_pressed() -> void:
	if conj_category != 0:
		conj_category = 0
		$Meaning.text = "сочинит."
	else: 
		conj_category = 1
		$Meaning.text = "подчинит."
	$Post.text = "разряд?"
	conj_postcategory = -1
	$Post.show()
	$LilSep2.show()

func _on_post_pressed() -> void:
	conj_postcategory += 1
	if conj_category == 1:
		match conj_postcategory:
			0: $Post.text = "временной"
			1: $Post.text = "причинный"
			2: $Post.text = "целевой"
			3: $Post.text = "условный"
			4: $Post.text = "уступительный"
			5: $Post.text = "сравнительный"
			6: $Post.text = "следственный"
			7: $Post.text = "изъяснительный"
			8: $Post.text = "места"
			9: $Post.text = "образа действия"
			_: $Post.text = "временной"; conj_postcategory = 0
	else:
		match conj_postcategory:
			0: $Post.text = "соединительный"
			1: $Post.text = "противительный"
			2: $Post.text = "разделительный"
			_: $Post.text = "соединительный"; conj_postcategory = 0
#endregion

#region Проверка ответов
func _ready() -> void:	
	Global.check_button.pressed.connect(checks)

func checks() -> void:
	if $IsCompound.text == Global.task[23]:
		Global.make_correct($IsCompound)
	else: Global.make_incorrect($IsCompound)
	if $Meaning.text == Global.task[13]:
		Global.make_correct($Meaning)
	else: Global.make_incorrect($Form)
	if $Post.text == Global.task[27]:
		Global.make_correct($Post)
	else: Global.make_incorrect($Post)
#endregion
