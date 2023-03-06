extends Node2D


var new_cursor = load("res://assets/BossTable/Tasks/click_cursor.png")
var normal_cursor = load("res://assets/BossTable/Tasks/cursor.png")


func _on_TextureButton_mouse_entered():
	Input.set_custom_mouse_cursor(new_cursor, 0, Vector2(16,16))


func _on_TextureButton_mouse_exited():
	Input.set_custom_mouse_cursor(normal_cursor, 0, Vector2(16,16))
