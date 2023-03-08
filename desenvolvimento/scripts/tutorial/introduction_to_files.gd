extends Node2D

func _on_back_button_pressed():
	get_tree().change_scene("res://scenes/tutorial/Tutorial.tscn")

func _on_next_button_pressed():
	get_tree().change_scene("res://scenes/tutorial/introduction_to_task.tscn")
