extends Node2D

func _on_back_button_pressed():
	get_tree().change_scene("res://Cenas/introduction_to_task.tscn")

func _on_next_button_pressed():
	get_tree().change_scene("res://Cenas/Tempo.tscn")
