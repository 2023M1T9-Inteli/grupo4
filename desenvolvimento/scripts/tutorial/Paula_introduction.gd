extends Node2D

func _on_back_button_button_up():
	get_tree().change_scene("res://scenes/tutorial/Skip_button_explanning.tscn")
	

func _on_next_button_pressed():
	get_tree().change_scene("res://scenes/tutorial/File_explanning.tscn")
