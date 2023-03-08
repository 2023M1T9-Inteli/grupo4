tool
extends Control

"""
# PT_BR: Variaveis exportadas
# EN_US: Exported variables
"""

# PT_BR: Tamanho da coleção de slote
# EN_US: Slot Collection size
export(Vector2) var collection_size: Vector2 = Vector2(64, 64) setget _set_collection_size

# PT_BR: Funções para definir as variáveis
# EN_US: Functions to set variables
func _set_collection_size(newValue) -> void:
	collection_size = newValue
	self.rect_min_size = collection_size
	self.rect_size = collection_size

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
