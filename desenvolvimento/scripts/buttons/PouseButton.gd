extends TextureButton


onready var pause_scene = $Pause


func _ready():
	pause_scene.visible = false


func _on_TextureButton_pressed():
	pause_scene.open_pause_scene()
