extends Node2D

# PT_BR: Função que toca a música, realiza animação e aparece um texto final
# EN_US: Function that plays the music, performs animation and a final text appears
func _ready():
	Audio.play_music(Audio.final_music)
	$CanvasLayer/AnimationPlayerIn.play("Fade")
	$BackgroundFinal/RichTextLabel.bbcode_text ="Você se provou um ótimo lider e uma pessoa com grandes competências em delegação de tarefas! Continue com o bom trabalho e lembre-se: Se um dia quiser praticar... Basta jogar:"
	

# PT_BR: Quando o botão é pressionado, há uma nova animação na tela e vai para a tela de menu
# EN_US: When the button is pressed there is a new animation on the screen and it goes to the menu screen
func _on_Button_pressed():
	$CanvasLayer/AnimationPlayerOut.play("FadeOut")
	yield(get_tree().create_timer(2.5),"timeout")
	var __ = get_tree().change_scene("res://scenes/Menu.tscn")
