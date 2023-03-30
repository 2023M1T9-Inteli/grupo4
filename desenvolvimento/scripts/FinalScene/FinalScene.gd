extends Node2D


func _ready():
	Audio.play_music(Audio.final_music)
	$CanvasLayer/AnimationPlayer.play("Fade")
	$BackgroundFinal/RichTextLabel.bbcode_text ="Você se provou um ótimo lider e uma pessoa com grandes competências em delegação de tarefas! Continue com o bom trabalho e lembre-se: Se um dia quiser praticar... Basta jogar[color=#d69856] O TALENTO DE DELEGAR![/color]"
