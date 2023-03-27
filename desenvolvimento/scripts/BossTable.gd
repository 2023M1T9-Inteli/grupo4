extends Node2D

# PT_BR: Variáveis que definem as imagens do cursor.
# EN_US: Variables that define the cursor images.
var new_cursor = load("res://assets/Cursor/click_cursor.png")
var normal_cursor = load("res://assets/Cursor/cursor.png")


# PT_BR: Muda o cursor do mouse ao entrar no "TextureButton".
# EN_US: Change the mouse cursor when entering the "TextureButton".
func _on_TextureButton_mouse_entered():
	Input.set_custom_mouse_cursor(new_cursor, 0, Vector2(16,16))


# PT_BR: Muda o cursor do mouse ao sair do "TextureButton".
# EN_US: Change mouse cursor when leaving "TextureButton".
func _on_TextureButton_mouse_exited():
	Input.set_custom_mouse_cursor(normal_cursor, 0, Vector2(16,16))

# PT_BR (1): Função para tocar música quando a tarefa é colocada na mesa do funcionário.
# PT_BR (2): Parâmetro: slot - CenterContainer.
# EN_US (1): Function to play music when the task is dropped on the worker table.
# EN_US (2): Parameter: slot - CenterContainer.
func _on_WorkerTableControl2_get_item(_slot):
	$Task_soud.play()

# PT_BR (1): Função para tocar música quando a ficha é colocada na mesa do funcionário.
# PT_BR (2): Parâmetro: slot - CenterContainer.
# EN_US (1): Function to play music when the file is dropped on the worker table.
# EN_US (2): Parameter: slot - CenterContainer.
func _on_ProfileControl2_get_item(_slot):
	$Task_soud.play()
