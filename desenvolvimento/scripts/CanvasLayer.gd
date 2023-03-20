extends CanvasLayer

var is_paused = false setget set_is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_ExitButton_pressed():
	self.is_paused = !is_paused


func _on_Play_pressed():
	self.is_paused = false
	self.hide()


func _on_Button2_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")


func _on_Button3_pressed():
	$Options.show()


func _on_Button4_pressed():
	pass
