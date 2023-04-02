extends Node2D


func _ready():
	# PT_BR: Toca a música da fase
	# EN_US: Plays the phase music
	Audio.play_music(Audio.music_phase_1)


# PT_BR (1): Função que muda a animação do sprite quando acionada 
# PT_BR (2): Recebe o objeto anim como parâmetro, que é a animação do personagem
# EN_US (1): Function that changes the sprite animation when activated
# EN_US (2): Receives the anim object as parameter, that is the character animation
func change_anim(anim):
	$RosalinneAnimSprite.animation = anim


# PT_BR (1): Função que define se o sprite "Computer" deve aparecer ou ficar escondido 
# PT_BR (2): Recebe o booleano show_pc como parâmetro
# EN_US (1): Function that defines if the sprite "Computer" should appear or stay hidden
# EN_US (2): Receives the show_pc (boolean) as parameter
func show_pc(show_pc):
	# PT_BR: Se o a variável for acionada, o sprite deve aparecer na tela
	# EN_US: If the variable is activated, ths sprite should appear on screen
	if show_pc:
		$Computer.show() 
	# PT_BR: Caso contrário, ele deve ficar oculto 
	# EN_US: In other case, it should stay hidden
	else:
		$Computer.hide() 


# PT_BR: Função que define que após o pressionar do botão, a cena é mudada
# EN_US: Function that definas that after the press of the button, the scene is changed
func _on_Button_pressed():
	var __ = get_tree().change_scene("res://scenes/Menu.tscn")


# PT_BR: Função que define que quando a cena de diálogo terminar, o jogo inicia
# EN_US: Function that defines that when the dialog scene ends, the game start
func _on_DialogBox_finished_dialog():
	var __ = get_tree().change_scene("res://scenes/phase1/Phase1.tscn")


# PT_BR: Função que quando o botão de voltar do primeiro diálogo é clicado, volta para o tutorial
# EN_US: Function that when the back button of the first dialog is clicked, it goes back to the tutorial
func _on_DialogBox_exit_dialog():
	var __ = get_tree().change_scene("res://scenes/Phases.tscn")
