extends Node2D


func add_text(text: String):
	$VBoxContainer/Text.text = text
	
func clear_dialogue_box():
		$VBoxContainer/Text.text = ""



