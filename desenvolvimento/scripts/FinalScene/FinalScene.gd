extends Node2D

onready var final_music = load("res://assets/Audio/music/VictoryMusic (mp3cut.net).wav")

func _ready():
	Audio.play_music(final_music)
	$CanvasLayer/AnimationPlayer.play("Fade")
	$BackgroundFinal/RichTextLabel.bbcode_text ="Você se provou um ótimo lider e uma pessoa com grandes competências em delegação de tarefas! Continue com o bom trabalho e lembre-se: Se um dia quiser praticar... Basta jogar:"


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")

