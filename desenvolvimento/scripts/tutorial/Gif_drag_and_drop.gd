extends Node2D

func _on_back_button3_pressed():
	get_tree().change_scene("res://scenes/tutorial/introduction_to_task.tscn")


func _on_next_button3_pressed():
	get_tree().change_scene("res://scenes/tutorial/Tempo.tscn")
