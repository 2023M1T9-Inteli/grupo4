extends Node2D
signal next_tutorial()
signal back_tutorial()

func _on_next_button_pressed():
	emit_signal("next_tutorial")

func _on_back_button_pressed():
	emit_signal("back_tutorial")
