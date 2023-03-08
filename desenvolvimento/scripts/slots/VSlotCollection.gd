tool
extends VBoxContainer

# PT_BR: Inicializa as constantes locais
# EN_US: Initialize local constants
enum ORIENTATION_DIRECTION {
	X = 0,
	Y = 1,
}

"""
# PT_BR: Variaveis exportadas
# EN_US: Exported variables
"""

# PT_BR: Tamanho da coleção de slote
# EN_US: Slot Collection size
export(Vector2) var collection_size: Vector2 = Vector2(64, 64) setget _set_collection_size

# PT_BR: Ativar o espaçamento entre os itens
# EN_US: Enable spacing between items
export(bool) var active_space_between = true setget _set_active_space_between

# PT_BR: Ativar o espaçamento entre os itens
# EN_US: Enable spacing between items
export(ORIENTATION_DIRECTION) var orientation = ORIENTATION_DIRECTION.X

# PT_BR: Funções para definir as variáveis
# EN_US: Functions to set variables
func _set_collection_size(newValue) -> void:
	collection_size = newValue
	self.rect_min_size = collection_size
	self.rect_size = collection_size


func _set_active_space_between(newValue) -> void:
	active_space_between = newValue

# PT_BR: Inicializa as variáveis locais
# EN_US: Initialize local variables
var qtd_control_children = 0

func _ready():	
	# PT_BR (1): É necessário colocar o mouse filter como ignore, caso o contrário o drag não vai funcionar
	# PT_BR (2): Define todos os nós filhos como MOUSE_FILTER_IGNORE
	# PT_BR (3): Salva a quantidade de Controls dentro do nó
	
	# EN_US (1): It is necessary to put the mouse filter as ignore, otherwise the drag will not work
	# EN_US (2): Set all children as MOUSE_FILTER_IGNORE 
	# EN_US (3): Saves the amount of Controls inside the node
	var total_children_size = 0
	
	for child in get_children():
		if "mouse_filter" in child:
			child.mouse_filter = MOUSE_FILTER_IGNORE
		if child.is_in_group("slot"):
			qtd_control_children += 1
			total_children_size += _get_object_property_orientation(orientation, child.rect_size)
	
	# PT_BR (1): Se o space_between for verdadeiro
	# PT_BR (2): Chama a função para mudar a separação do node
	# EN_US (1): If the space_between is true
	# EN_US (2): Calls the function to change the node separation 
	if active_space_between:
		_change_separation_to_space_between(qtd_control_children, 
											total_children_size,
											_get_object_property_orientation(orientation, collection_size) )


# PT_BR (1): Recebe a quantidade de nós filhos, o tamanho total deles e o tamanho do container.
# PT_BR (2): Não retorna um valor
# EN_US (1): Receives the number of child nodes, their total size and the size of the container.
# EN_US (2): It does not return a value.
func _change_separation_to_space_between(qtd_childs, total_children_size, container_size):
	# PT_BR: Divide o espaço do Slot Collection igualmente entre os nós Control
	# EN_US: Divide Slot Collection space equally between controls nodes
	if (container_size - total_children_size) == 0:
		self.add_constant_override("separation", 
									_calc_space_between(container_size, total_children_size - 1, qtd_childs) )
	else:
		self.add_constant_override("separation", 
									_calc_space_between(container_size, total_children_size, qtd_childs) )


# PT_BR (1): Recebe a quantidade de nós filhos, o tamanho total deles e o tamanho do container.
# PT_BR (2): Retorna a distância adequada entre os nodes
# EN_US (1): Receives the number of child nodes, their total size and the size of the container.
# EN_US (2): Return proper distance between nodes
func _calc_space_between(container_size, total_children_size, qtd_childs):
	return ( (container_size - total_children_size) / (qtd_childs - 1) )


# PT_BR (1): Recebe o tamanho do slotCollection e a quantidade de nodes filhos
# PT_BR (2): Retorna o tamanho que cada slot deve ter
# EN_US (1): Receive the slotCollection size and the number of child nodes
# EN_US (2): Returns the size each slot should be
func _calc_slot_size(slot_collection_size, qtd_child):
	return ( (slot_collection_size) / qtd_child )


# PT_BR (1): Recebe a orientação a ser obtida e a propriedade do objeto (Vector2)
# PT_BR (2): Não retorna um valor
# EN_US (1): Receives the orientation to be obtained and the object property (Vector2)
# EN_US (2): It does not return a value.
func _get_object_property_orientation(object_orientation, object_property: Vector2):
	# PT_BR: Essa função pega a orientação de uma propriedade que seja um Vector2
	# EN_US: This function takes the orientation of a Vector2 property
	if object_orientation == ORIENTATION_DIRECTION.X:
		return object_property.x
	elif object_orientation == ORIENTATION_DIRECTION.Y:
		return object_property.y

""" 
DRAG AND DROP
"""

# PT_BR (1): No get_drag_data é dividido na horizontal um espaço igual para cada Control
# PT_BR (2): Depois é visto todos os Controls no nó e definido o começo e o fim do espaço
# PT_BR (3): Ao final, é verificado se a posição horizontal clicada é a que o Control está
# EN_US (1): In get_drag_data an equal horizontally space is divided for each Control
# EN_US (2): Set all children as MOUSE_FILTER_IGNORE 
# EN_US (3): At the end, it is checked if the clicked horizontal position is the one the Control is in.
func get_drag_data(position):
	var actual_child = 0
	var orientation_position = _get_object_property_orientation(orientation, position)
	for child in self.get_children():
		if child.is_in_group("slot"):
			var min_position = _calc_slot_size(_get_object_property_orientation(orientation, collection_size), 
												qtd_control_children) * (actual_child)
			var max_position = _calc_slot_size(_get_object_property_orientation(orientation, collection_size), 
												qtd_control_children) * (actual_child + 1)
			if min_position <= orientation_position and orientation_position <= max_position:
				return child.get_drag_data(position)
			actual_child += 1


# PT_BR: Verifica se algum Control filho aceita o objeto que está sendo arrastado e retorna o resultado
# EN_US: Checks if any child Control accepts the object being dragged and returns the result
func can_drop_data(position, data) -> bool:
	var can_drop = false
	for child in self.get_children():
		if child.is_in_group("slot"):
			can_drop = can_drop or child.can_drop_data(position, data)
			if can_drop:
				return can_drop
	return can_drop


# PT_BR: Checa qual dos Controls filhos aceita o objeto e, ao achar, o envia o objeto arrastado para o Control
# EN_US: Checks which of the child Controls accepts the object and, when found, sends the dragged object to the Control
func drop_data(position, data) -> void:
	for child in self.get_children():
		if child.is_in_group("slot") and child.can_drop_data(position, data):
			child.drop_data(position, data)
			return
