tool
extends Control

""" 
DRAG AND DROP
"""

# PT_BR: Verifica se algum Control filho aceita o objeto que está sendo arrastado e retorna o resultado
# EN_US: Checks if any child Control accepts the object being dragged and returns the result
func can_drop_data(position, data) -> bool:
	var can_drop = false
	for child in self.get_children():
		if child is Control:
			can_drop = can_drop or child.can_drop_data(position, data)
			if can_drop:
				return can_drop
	return can_drop


# PT_BR (1): Checa qual dos Controls filhos aceita o objeto
# PT_BR (2): Ao achar, o envia o objeto arrastado para o Control
# EN_US (1): Checks which of the child Controls accepts the object and
# EN_US (2): When found, sends the dragged object to the Control
func drop_data(position, data) -> void:
	for child in self.get_children():
		if child is Control and child.can_drop_data(position, data):
			child.drop_data(position, data)
			return
