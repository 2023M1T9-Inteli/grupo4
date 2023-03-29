extends Node2D


# PT_BR: Variável local que armazena a música da fase 2
# EN_US: Local variable that stores the music from phase 2
onready var music_phase_2 = load("res://assets/Audio/music/music_phase_2.wav")


func _ready():
	Audio.play_music(music_phase_2)


# PT_BR: Função que muda a animação do sprite quando acionada 
# EN_US: Function that changes the sprite animation when activated
func change_anim(anim):
	$ChicoAnimatedSprite.animation = anim


# PT_BR: Função que define se o sprite "Computer" deve aparecer ou ficar escondido 
# EN_US: Function that defines if the sprite "Computer" should appear or stay hidden
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
	get_tree().change_scene("res://scenes/Menu.tscn")


# PT_BR: Função que define que quando a cena de diálogo terminar, o jogo inicia.
# EN_US: Function that defines that when the dialog scene ends, the game start.
func _on_DialogBox_finished_dialog():
	get_tree().change_scene("res://scenes/phase2/Phase2.tscn")


# PT_BR: Função que quando o botão de voltar do primeiro diálogo é clicado, volta para a tela de fases
# EN_US: Function that when the back button of the first dialog is clicked, it goes back to the stages screen
func _on_DialogBox_exit_dialog():
	get_tree().change_scene("res://scenes/Phases.tscn")
