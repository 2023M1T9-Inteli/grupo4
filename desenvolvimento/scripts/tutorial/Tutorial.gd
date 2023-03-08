extends Node2D


func _on_next_button_pressed():
	get_tree().change_scene("res://scenes/tutorial/introduction_to_file.tscn")

func _on_Skip_button_pressed():
	get_tree().change_scene("res://Cenas/Progress.tscn")
