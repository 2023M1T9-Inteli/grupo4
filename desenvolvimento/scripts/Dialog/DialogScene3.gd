extends Node2D


func _ready():
	# PT_BR: Toca a música da fase
	# EN_US: Plays the phase music
	Audio.play_music(Audio.music_phase_3)


# PT_BR (1): Função que muda a animação do sprite quando acionada 
# PT_BR (2): Recebe o objeto anim como parâmetro
# EN_US (1): Function that changes the sprite animation when activated
# EN_US (2): Receives the anim object as parameter
func change_anim(anim):
	$XarmesAnimatedSprite.animation = anim


# PT_BR (1): Função que define se o sprite "Gift" deve aparecer ou ficar escondido 
# PT_BR (2): Parâmetro: show_gift: bool- ícone do projeto da fase
# EN_US (1): Function that defines if the sprite "Gift" should appear or stay hidden
# EN_US (2): Parameter: show_gift: bool - stage design icon
func show_gift(show_gift):
	# PT_BR: Se o a variável for acionada, o sprite deve aparecer na tela
	# EN_US: If the variable is activated, ths sprite should appear on screen
	if show_gift:
		$Gift.show() 
	
	# PT_BR: Caso contrário, ele deve ficar oculto 
	# EN_US: In other case, it should stay hidden
	else:
		$Gift.hide() 


# PT_BR (1): Função que define se o sprite "bento" deve aparecer ou ficar escondido 
# PT_BR (2): Parâmetro: show_bento: bool- ícone do projeto da fase
# EN_US (1): Function that defines if the sprite "bento" should appear or stay hidden
# EN_US (2): Parameter: show_tent: bool - stage design icon
func show_bento(show_bento):
	# PT_BR: Se o a variável for acionada, o sprite deve aparecer na tela
	# EN_US: If the variable is activated, ths sprite should appear on screen
	if show_bento:
		$Bento.show()
	
	# PT_BR: Caso contrário, ele deve ficar oculto 
	# EN_US: In other case, it should stay hidden
	else:
		$Bento.hide()


# PT_BR: Função que define que após o pressionar do botão, a cena é mudada para o 
# EN_US: Function that defines that after the press of the button, the scene is changed
func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")


# PT_BR: Função que define que quando a cena de diálogo terminar, o jogo inicia.
# EN_US: Function that defines that when the dialog scene ends, the game start.
func _on_DialogBox_finished_dialog():
	get_tree().change_scene("res://scenes/phase3/Phase3.tscn")


# PT_BR: Função que quando o botão de voltar do primeiro diálogo é clicado, volta para a tela de fases
# EN_US: Function that when the back button of the first dialog is clicked, it goes back to the stages screen
func _on_DialogBox_exit_dialog():
	get_tree().change_scene("res://scenes/Phases.tscn")
