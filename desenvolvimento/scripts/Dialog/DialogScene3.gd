extends Node2D

# PT_BR (1): Função que muda a animação do sprite quando acionada 
# PT_BR (2): Recebe o objeto anim como parâmetro
# EN_US (1): Function that changes the sprite animation when activated
# EN_US (2): Receives the anim object as parameter
func change_anim(anim):
	$XarmesAnimatedSprite.animation = anim


# PT_BR (1): Função que define se o sprite "gift_circle" deve aparecer ou ficar escondido 
# PT_BR (2): Parâmetro: show_tent - ícone do projeto da fase
# EN_US (1): Function that defines if the sprite "gift_circle" should appear or stay hidden
# EN_US (2): Parameter: show_tent - stage design icon
func show_tent(show_tent):
	# PT_BR: Se o a variável for acionada, o sprite deve aparecer na tela
	# EN_US: If the variable is activated, ths sprite should appear on screen
	if show_tent:
		$Gift.show() 
	# PT_BR: Caso contrário, ele deve ficar oculto 
	# EN_US: In other case, it should stay hidden
	else:
		$Gift.hide() 
		
		
# PT_BR: Função que define que após o pressionar do botão, a cena é mudada para o 
# EN_US: Function that defines that after the press of the button, the scene is changed
func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")


# PT_BR: Função que define que quando a cena de diálogo terminar, o jogo inicia.
# EN_US: Function that defines that when the dialog scene ends, the game start.
func _on_DialogBox_finished_dialog():
	get_tree().change_scene("res://scenes/phase2/Phase2.tscn")


# PT_BR: Função que quando o botão de voltar do primeiro diálogo é clicado, volta para a tela de fases
# EN_US: Function that when the back button of the first dialog is clicked, it goes back to the stages screen
func _on_DialogBox_exit_dialog():
	get_tree().change_scene("res://scenes/Phases.tscn")
