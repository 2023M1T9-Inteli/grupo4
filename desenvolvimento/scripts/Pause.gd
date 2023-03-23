extends CanvasLayer

var is_paused = false setget set_is_paused

var phase_1_music = preload("res://assets/Audio/music_phase_1.mp3")

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_ContinueButton_pressed():
	self.is_paused = false
	self.hide()
	$Depaused_sound.play()
	Audio.change_music(phase_1_music)
	

func _on_OptionsButton_pressed():
	$Options.show()
	

func _on_QuitButton_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
	self.is_paused = false
	


func _on_ExitButton_pressed():
	self.is_paused = !is_paused	
	pass # Replace with function body.
	

func _on_TutorialButton_pressed():
	$PopupMenu.open_tutorial()
	pass # Replace with function body.
