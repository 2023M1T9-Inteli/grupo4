extends Control



func _ready():
	
	pass # Replace with function body.




func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/concept-scene.tscn")
	


func _on_Creditos_button_up():
	get_tree().change_scene("res://scenes/Créditos.tscn")




func _on_OptionsButton_pressed():
	get_tree().change_scene("res://scenes/Opcoes.tscn")

