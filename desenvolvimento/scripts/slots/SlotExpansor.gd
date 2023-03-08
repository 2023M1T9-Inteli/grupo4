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
			return child.can_drop_data(position, data)
	return can_drop


# PT_BR: Checa qual dos Controls filhos aceita o objeto e, ao achar, o envia o objeto arrastado para o Control
# EN_US: Checks which of the child Controls accepts the object and, when found, sends the dragged object to the Control
func drop_data(position, data) -> void:
	
	for child in self.get_children():
		if child is Control and child.can_drop_data(position, data):
			child.drop_data(position, data)
			return
