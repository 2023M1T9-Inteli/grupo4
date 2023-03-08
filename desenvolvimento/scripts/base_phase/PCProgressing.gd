extends TextureProgress



func _ready():
	
	pass # Replace with function body.

func pc_processing():
	self.value += 9
	if self.value == 81:
		get_tree().change_scene("res://scenes/base_phase/Victory.tscn")
