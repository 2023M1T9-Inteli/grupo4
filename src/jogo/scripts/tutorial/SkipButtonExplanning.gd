extends Node2D

signal next_tutorial()
signal end_tutorial()

func _on_skip_button_pressed():
	emit_signal("end_tutorial")


func _on_next_button_pressed():
	emit_signal("next_tutorial")




