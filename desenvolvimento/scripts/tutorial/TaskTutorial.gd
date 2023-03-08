extends Node2D

func _on_back_button2_pressed():
	get_tree().change_scene("res://scenes/tutorial/FileTutorial.tscn")


func _on_next_button2_pressed():
	get_tree().change_scene("res://scenes/tutorial/DragAndDropTutorial.tscn")
