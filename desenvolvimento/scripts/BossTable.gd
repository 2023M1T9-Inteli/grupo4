extends Node2D


var novo_cursor = load("res://imagem/cursor_clique.png")
var cursor = load("res://imagem/cursor.png")


func _on_TextureButton_mouse_entered():
	Input.set_custom_mouse_cursor(novo_cursor, 0, Vector2(16,16))


func _on_TextureButton_mouse_exited():
	Input.set_custom_mouse_cursor(cursor, 0, Vector2(16,16))
