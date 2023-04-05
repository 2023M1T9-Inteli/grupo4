tool
extends HBoxContainer

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

# PT_BR: Seleciona a orientação do objeto
# EN_US: Selected object orientation
export(ORIENTATION_DIRECTION) var orientation = ORIENTATION_DIRECTION.X


# PT_BR (1): Funções para definir as variáveis. 
# PT_BR (2): Parâmetro: new_value
# EN_US (1): Functions to set variables. 
# EN_US (2): Parameter: new_value
func _set_collection_size(new_value) -> void:
	collection_size = new_value
	self.rect_min_size = collection_size
	self.rect_size = collection_size


func _set_active_space_between(new_value) -> void:
	active_space_between = new_value

# PT_BR: Inicializa as variáveis locais
# EN_US: Initialize local variables
var qtd_control_children = 0


func _ready():	
	# PT_BR (1): É necessário colocar o mouse filter como ignore, caso o contrário o drag não vai funcionar
	# PT_BR (2): Define todos os nós filhos como MOUSE_FILTER_IGNORE
	
	# EN_US (1): It is necessary to put the mouse filter as ignore, otherwise the drag will not work
	# EN_US (2): Set all children as MOUSE_FILTER_IGNORE 
	var total_children_size = 0
	
	for child in get_children():
		if "mouse_filter" in child:
			child.mouse_filter = MOUSE_FILTER_IGNORE
			
		# PT_BR: Se o filho é do grupo slot
		# EN_US: If child is in group slot
		if child.is_in_group("slot"):
			# PT_BR: Contabiliza a quantidade de filhos que são slots e o tamanho total deles
			# EN_US: Counts the number of children that are slots and their total size
			qtd_control_children += 1
			total_children_size += _get_object_property_orientation(orientation, child.rect_size)
	
	# PT_BR: Se o space_between for verdadeiro
	# EN_US: If the space_between is true
	if active_space_between:
		# PT_BR: Chama a função para mudar a separação do node
		# EN_US: Calls the function to change the node separation 
		_change_separation_to_space_between(qtd_control_children, 
											total_children_size,
											_get_object_property_orientation(orientation, collection_size) )


# PT_BR (1): Função que muda a constante de separação do SlotCollection
# PT_BR (2): Parâmetro: qtd_child int, total_children_size int, container_size int
# EN_US (1): Function that changes the constant separation of the SlotCollection
# EN_US (2): Parameter: qtd_child int, total_children_size int, container_size int
func _change_separation_to_space_between(qtd_childs, total_children_size, container_size):
	# PT_BR: Divide o espaço do Slot Collection igualmente entre os nós Control
	# EN_US: Divide Slot Collection space equally between controls nodes
	if (container_size - total_children_size) == 0:
		self.add_constant_override("separation", 
									_calc_space_between(container_size, total_children_size - 1, qtd_childs) )
	else:
		self.add_constant_override("separation", 
							_calc_space_between(container_size, total_children_size, qtd_childs) )


# PT_BR (1): Função que calcula o espaço que deve ter entre os nós filhos
# PT_BR (2): Parâmetro: qtd_child int, total_children_size int, container_size int
# PT_BR (3): Retorna a distância adequada entre os nodes
# EN_US (1): Function that calculates the space that should be between child nodes
# EN_US (2): Parameter: qtd_child int, total_children_size int, container_size int
# EN_US (3): Return proper distance between nodes
func _calc_space_between(container_size, total_children_size, qtd_childs):
	return ( (container_size - total_children_size) / (qtd_childs - 1) )


# PT_BR (1): Função para calcular o tamanho que cada slot deve ter
# PT_BR (2): Parâmetro: slot_collection_size int, qtd_child int
# PT_BR (3): Retorna o tamanho que cada slot deve ter
# EN_US (1): Function to calculate the size that each slot should be
# EN_US (2): Parameter: slot_collection_size int, qtd_child int
# EN_US (3): Returns the size each slot should be
func _calc_slot_size(slot_collection_size, qtd_child):
	return ( (slot_collection_size) / qtd_child )


# PT_BR (1): Função que retorna o tamanho de um Vector2 de um objeto na orientação enviada
# PT_BR (2): Parâmetro: object_orientation: enum ORIENTATION_DIRECTION, object_property Vector2
# EN_US (1): Function that returns the size of a Vector2 of an object in the sent orientation
# EN_US (2): Parameter: object_orientation: enum ORIENTATION_DIRECTION, object_property Vector2
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

func get_drag_data(position):
	# PT_BR (1): No get_drag_data é dividido na horizontal um espaço igual para cada Control
	# PT_BR (2): Depois é visto todos os Controls no nó e definido o começo e o fim do espaço
	# EN_US (1): In get_drag_data an equal horizontally space is divided for each Control
	# EN_US (2): Then all the Controls in the node are seen and the beginning and end of the space are defined.
	var actual_child = 0
	var orientation_position = _get_object_property_orientation(orientation, position)
	for child in self.get_children():
		if child.is_in_group("slot"):
			var min_position = _calc_slot_size(_get_object_property_orientation(orientation, collection_size), 
												qtd_control_children) * (actual_child)
			var max_position = _calc_slot_size(_get_object_property_orientation(orientation, collection_size), 
												qtd_control_children) * (actual_child + 1)
			
			# PT_BR: Se posição horizontal clicada é a que o Control deveria estar
			# EN_US: If clicked horizontal position is where the Control should be
			if min_position <= orientation_position and orientation_position <= max_position:
				return child.get_drag_data(position)
			actual_child += 1


func can_drop_data(position, data) -> bool:
	# PT_BR: Verifica se algum Control filho aceita o objeto que está sendo arrastado e retorna o resultado
	# EN_US: Checks if any child Control accepts the object being dragged and returns the result
	var can_drop = false
	for child in self.get_children():
		if child.is_in_group("slot"):
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
		if child.is_in_group("slot") and child.can_drop_data(position, data):
			child.drop_data(position, data)
			return
