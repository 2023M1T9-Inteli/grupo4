extends Node2D

func change_anim(anim):
	$RosalinneAnimSprite.animation = anim

func show_pc(show_pc):
	if show_pc:
		$Computer.show() 
	else:
		$Computer.hide() 

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
