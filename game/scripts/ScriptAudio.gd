extends Node

var thememusic = load("res://assets/Audio/focus-loop-corporate-music-114297.mp3")

func _ready():
	pass
	
func _play_music():
	$Music.stream = thememusic
	$Music.play()
