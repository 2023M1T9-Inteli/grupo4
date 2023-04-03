extends Node2D

func _ready():
	# PT_BR: Toca a música da fase
	# EN_US: Plays the phase music
	Audio.play_music(Audio.music_phase_2)


# PT_BR (1): Função que muda a animação do sprite quando acionada 
# PT_BR (2): Recebe o objeto anim como parâmetro
# EN_US (1): Function that changes the sprite animation when activated
# EN_US (2): Receives the anim object as parameter
func change_anim(anim):
	$ChicoAnimatedSprite.animation = anim

# PT_BR (1): Função que define se o sprite "tend_circle" deve aparecer ou ficar escondido 
# PT_BR (2): Recebe o objeto show_tent como parâmetro
# EN_US (1): Function that defines if the sprite "tend_circle" should appear or stay hidden
# EN_US (2): Receives the show_tent object as parameter
func show_tent(show_tent):
	# PT_BR: Se o a variável for acionada, o sprite deve aparecer na tela
	# EN_US: If the variable is activated, ths sprite should appear on screen
	if show_tent:
		$Tent.show() 
	# PT_BR: Caso contrário, ele deve ficar oculto 
	# EN_US: In other case, it should stay hidden
	else:
		$Tent.hide() 
		
		
# PT_BR: Função que define que após o pressionar do botão, a cena é mudada para o 
# EN_US: Function that defines that after the press of the button, the scene is changed
func _on_Button_pressed():
	var __ = get_tree().change_scene("res://scenes/Menu.tscn")


# PT_BR: Função que define que quando a cena de diálogo terminar, o jogo inicia.
# EN_US: Function that defines that when the dialog scene ends, the game start.
func _on_DialogBox_finished_dialog():
	var __ = get_tree().change_scene("res://scenes/phase2/Phase2.tscn")


# PT_BR: Função que quando o botão de voltar do primeiro diálogo é clicado, volta para a tela de fases
# EN_US: Function that when the back button of the first dialog is clicked, it goes back to the stages screen
func _on_DialogBox_exit_dialog():
	var __ = get_tree().change_scene("res://scenes/Phases.tscn")
