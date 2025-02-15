extends Control

var morfi_scene: PackedScene = preload("res://content/morfi.tscn")


func _ready():
	pass

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(morfi_scene)

# TODO:
func _on_about_link_button_pressed() -> void:
	pass
