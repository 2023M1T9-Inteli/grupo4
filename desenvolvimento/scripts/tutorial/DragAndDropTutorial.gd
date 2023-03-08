extends Node2D

func _on_back_button3_pressed():
	get_tree().change_scene("res://scenes/tutorial/TaskTutorial.tscn")


func _on_next_button3_pressed():
	get_tree().change_scene("res://scenes/tutorial/TimeTutorial.tscn")
