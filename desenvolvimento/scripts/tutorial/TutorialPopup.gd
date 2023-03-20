extends PopupMenu


func _input(event):
	if event.is_action_pressed("home"):
		get_tree().quit()
