extends CanvasLayer

# PT_BR: Variável booleana que armazena se o jogo está pausado.
# EN_US: Boolean variable that stores whether the game is paused.
var is_paused = false setget set_is_paused

# PT_BR: Variável que armazena a trilha sonora da fase 1.
# EN_US: Variable that stores the phase 1 soundtrack.
var phase_1_music = preload("res://assets/Audio/music_phase_1.mp3")

# PT_BR: Função executada sempre que a variável is paused é definida. Recebe value como parâmetro.
# EN_US: Function executed every time that the variable is paused is defined. Receives value as parameter.
func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


# PT_BR: Função executada quando o botão continuar é apertado para anular o pause.
# EN_US: Function executed when the continue button is pressed to null the pause.
func _on_ContinueButton_pressed():
	self.is_paused = false
	self.hide()
	$Depaused_sound.play()
	Audio.change_music(phase_1_music)
	

# PT_BR: Função executada quando o botão opções é apertado para mostrar o objeto Options.
# EN_US: Function executed when the options button is pressed to show the Options object.
func _on_OptionsButton_pressed():
	$Options.show()
	

# PT_BR: Função executada quando o botão sair é apertado que volta ao menu do jogo.
# EN_US: Function executed when the exit button is pressed which returns to the game menu.
func _on_QuitButton_pressed():
	var __ = get_tree().change_scene("res://scenes/Menu.tscn")
	self.is_paused = false
	

# PT_BR: Função executada quando o botão pause é apertado que define a variável is paused.
# EN_US: Function executed when the pause button is pressed that defines the variable is paused.
func _on_Pause_button_pressed():
	self.is_paused = !is_paused	


# PT_BR: Função executada quando o botão tutorial é apertado que abre o popup do tutorial.
# EN_US: Function executed when the tutorial button is pressed to open the tutorial popup.
func _on_TutorialButton_pressed():
	$PopupMenu.open_tutorial()
