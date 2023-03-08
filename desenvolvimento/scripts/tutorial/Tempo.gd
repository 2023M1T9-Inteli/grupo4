extends Node2D


func _on_back_button4_pressed():
	get_tree().change_scene("res://scenes/tutorial/Gif_drag_and_drop.tscn")
	

func _on_next_button4_pressed():
	get_tree().change_scene("res://scenes/tutorial/Progress.tscn")
