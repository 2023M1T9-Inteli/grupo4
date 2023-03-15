extends CanvasLayer

var is_paused = false setget set_is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused



func _on_ExitButton_pressed():
	self.is_paused = !is_paused
	pass # Replace with function body.


func _on_Play_pressed():
	self.is_paused = false
	self.hide()
	pass # Replace with function body.


func _on_Button2_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
	pass # Replace with function body.


func _on_Button3_pressed():
	$Options.show()
	pass # Replace with function body.


func _on_Button4_pressed():
	pass # Replace with function body.
