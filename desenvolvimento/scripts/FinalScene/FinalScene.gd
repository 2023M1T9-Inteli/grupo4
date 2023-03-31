extends Node2D


func _ready():
	Audio.play_music(Audio.final_music)
	$CanvasLayer/AnimationPlayerIn.play("Fade")
	$BackgroundFinal/RichTextLabel.bbcode_text ="Você se provou um ótimo lider e uma pessoa com grandes competências em delegação de tarefas! Continue com o bom trabalho e lembre-se: Se um dia quiser praticar... Basta jogar:"
	

func _on_Button_pressed():
	print("clicou")
	$CanvasLayer/AnimationPlayerOut.play("FadeOut")
	yield(get_tree().create_timer(2.5),"timeout")
	get_tree().change_scene("res://scenes/Menu.tscn")

