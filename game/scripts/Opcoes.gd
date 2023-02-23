extends Control

var master_bus = AudioServer.get_bus_index("Master")


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
	pass # Replace with function body.


func _on_SliderMusic_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -40:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus,false)
	
	
	pass # Replace with function body.

