extends ScrollContainer

# PT_BR: Define o tamanho do ScrollContainer
# EN_US: Set the ScrollContainer size
export(Vector2) var scroll_container_size: Vector2 = Vector2(64, 64) setget _set_scroll_container_size

# PT_BR (1): Funções para definir as variáveis. 
# PT_BR (2): Parâmetro: new_value
# EN_US (1): Functions to set variables. 
# EN_US (2): Parameter: new_value
func _set_scroll_container_size(new_value) -> void:
	scroll_container_size = new_value
	self.rect_size = scroll_container_size

""" 
DRAG AND DROP
"""


func can_drop_data(position, data) -> bool:
	# PT_BR: Verifica se algum Control filho aceita o objeto que está sendo arrastado e retorna o resultado
	# EN_US: Checks if any child Control accepts the object being dragged and returns the result
	var can_drop = false
	for child in self.get_children():
		if child is Control:
			can_drop = can_drop or child.can_drop_data(position, data)
			if can_drop:
				return can_drop
	return can_drop


func drop_data(position, data) -> void:
	# PT_BR (1): Checa qual dos Controls filhos aceita o objeto
	# PT_BR (2): Ao achar, o envia o objeto arrastado para o Control
	# EN_US (1): Checks which of the child Controls accepts the object and
	# EN_US (2): When found, sends the dragged object to the Control
	for child in self.get_children():
		if child is Control and child.can_drop_data(position, data):
			child.drop_data(position, data)
