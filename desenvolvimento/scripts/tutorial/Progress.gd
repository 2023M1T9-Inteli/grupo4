extends Node2D


func _on_back_button_pressed():
	get_tree().change_scene("res://Cenas/Tempo.tscn")


func _on_start_button_pressed():
	get_tree().change_scene("res://Cenas/Tutorial.tscn")
