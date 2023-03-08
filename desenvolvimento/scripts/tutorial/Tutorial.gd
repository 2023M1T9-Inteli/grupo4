extends Node2D


func _on_next_button_pressed():
	get_tree().change_scene("res://scenes/tutorial/FileTutorial.tscn")

func _on_Skip_button_pressed():
	get_tree().change_scene("res://scenes/Phases.tscn")
