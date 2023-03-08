extends Node2D

func _on_back_button_pressed():
	get_tree().change_scene("res://Cenas/introduction_to_file.tscn")

func _on_next_button_pressed():
	get_tree().change_scene("res://Cenas/Gif_drag_and_drop.tscn")
