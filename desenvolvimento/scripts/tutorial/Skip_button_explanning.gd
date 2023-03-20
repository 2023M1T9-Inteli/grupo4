extends Node2D

func _on_skip_button_pressed():
	get_tree().change_scene("res://scenes/Phases.tscn")

func _on_back_button_pressed():
	get_tree().change_scene("res://scenes/tutorial/Introduction_tutorial.tscn")

func _on_next_button_pressed():
	get_tree().change_scene("res://scenes/tutorial/Paula_introduction.tscn")



