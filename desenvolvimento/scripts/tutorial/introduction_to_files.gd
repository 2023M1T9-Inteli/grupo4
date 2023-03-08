extends Node2D

func _on_back_button2_pressed():
	get_tree().change_scene("res://scenes/tutorial/introduction_to_file.tscn")


func _on_next_button2_pressed():
	get_tree().change_scene("res://scenes/tutorial/Gif_drag_and_drop.tscn")
