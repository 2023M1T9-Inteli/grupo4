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
export(Vector2) var drawer_size: Vector2 = Vector2(64, 64) setget _set_drawer_size

# PT_BR: Tamanho da coleção de slote
# EN_US: Slot Collection size
export var qtd_task: int = 10 setget _set_qtd_task

# PT_BR: Ativar o espaçamento entre os itens
# EN_US: Enable spacing between items
export(ORIENTATION_DIRECTION) var orientation = ORIENTATION_DIRECTION.X

# PT_BR: Funções para definir as variáveis
# EN_US: Functions to set variables
func _set_drawer_size(new_value) -> void:
	drawer_size = new_value
	self.rect_min_size = drawer_size
	self.rect_size = drawer_size

func _set_qtd_task(new_value) -> void:
	qtd_task = new_value
	drawer_size.x = new_value * 64

# PT_BR: Inicializa as variáveis locais=-
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
			if child.connect("dropped_item", self, "_delete_slot") != OK:
				print("Erro ao conectar o sinal dropped_item do node ", self)
	self.rect_min_sizev.x = total_children_size


# PT_BR (1): Recebe o tamanho do slotCollection e a quantidade de nodes filhos
# PT_BR (2): Retorna o tamanho que cada slot deve ter
# EN_US (1): Receive the slotCollection size and the number of child nodes
# EN_US (2): Returns the size each slot should be
func _calc_slot_size(slot_collection_size, qtd_child):
	return ( (slot_collection_size) / qtd_child )

# PT_BR (1): Função para definir o tamanho horizonta do slot collection. 
# PT_BR (2): Recebe o quanto o slot deve aumentar ou diminuir.
# EN_US (1): Function to define the horizontal size of the slot collection. 
# EN_US (2): Gets how much the slot should grow or shrink.
func _set_slot_collection_size_x():
	var new_size_x = 0
	for child in get_children():
		if child.is_in_group("slot"):
			new_size_x += child.rect_size.x
		
	_set_drawer_size( Vector2(new_size_x, self.drawer_size.y) )
	

# PT_BR (1): Recebe a orientação a ser obtida e a propriedade do objeto (Vector2)
# PT_BR (2): Retorna o valor daquela propriedade na orientação informada
# EN_US (1): Receives the orientation to be obtained and the object property (Vector2)
# EN_US (2): Returns the value of that property in the given orientation.
func _get_object_property_orientation(object_orientation, object_property: Vector2):
	# PT_BR: Essa função pega a orientação de uma propriedade que seja um Vector2
	# EN_US: This function takes the orientation of a Vector2 property
	if object_orientation == ORIENTATION_DIRECTION.X:
		return object_property.x
	elif object_orientation == ORIENTATION_DIRECTION.Y:
		return object_property.y


# PT_BR (1): Função para apagar um node filho e ajustar o tamanho a quantidade de nodes. 
# PT_BR (2): Recebe o node.
# EN_US (1): Function to delete a child node and adjust the size to the number of nodes. 
# EN_US (2): Receives the node.
func _delete_slot(node) -> void:
	node.queue_free()
	_count_control_childs()
	self._set_slot_collection_size_x()


# PT_BR (1): Função para duplicar o slot padrão dentro de root. 
# PT_BR (2): Retorna o novo slot
# EN_US (1): Function to duplicate the default slot inside root. 
# EN_US (2): Returns the new slot
func _duplicate_slot():
	var new_slot = $root/SlotExample.duplicate()
	new_slot.connect("dropped_item", self, "_delete_slot")
	return new_slot


# PT_BR: Função que conta os controls filhos
# EN_US: Function that counts child controls
func _count_control_childs():
	var new_qtd = 0
	for child in self.get_children():
		if child.is_in_group("slot"):
				new_qtd += 1
	qtd_control_children = new_qtd

""" 
DRAG AND DROP
"""

func get_drag_data(position):
	# PT_BR (1): No get_drag_data é dividido na horizontal um espaço igual para cada Control
	# PT_BR (2): Depois é visto todos os Controls no nó e definido o começo e o fim do espaço
	# PT_BR (3): Ao final, é verificado se a posição horizontal clicada é a que o Control está
	# EN_US (1): In get_drag_data an equal horizontally space is divided for each Control
	# EN_US (2): Set all children as MOUSE_FILTER_IGNORE 
	# EN_US (3): At the end, it is checked if the clicked horizontal position is the one the Control is in.
	var actual_child = 0
	var orientation_position = _get_object_property_orientation(orientation, position)
	for child in self.get_children():
		if child.is_in_group("slot"):
			var min_position = _calc_slot_size(_get_object_property_orientation(orientation, drawer_size), 
												qtd_control_children) * (actual_child)
			var max_position = _calc_slot_size(_get_object_property_orientation(orientation, drawer_size), 
												qtd_control_children) * (actual_child + 1)
			if min_position <= orientation_position and orientation_position <= max_position:
				return child.get_drag_data(position)
			actual_child += 1


# PT_BR: Verifica se algum Control filho aceita o objeto que está sendo arrastado e retorna o resultado
# EN_US: Checks if any child Control accepts the object being dragged and returns the result
func can_drop_data(position, data) -> bool:
	return $root/SlotExample.can_drop_data(position, data)


# PT_BR: Checa qual dos Controls filhos aceita o objeto e, ao achar, o envia o objeto arrastado para o Control
# EN_US: Checks which of the child Controls accepts the object and, when found, sends the dragged object to the Control
func drop_data(position, data) -> void:
	var new_slot = _duplicate_slot()
	new_slot.drop_data(position, data)
	.add_child(new_slot)
	_count_control_childs()
	_set_slot_collection_size_x()
	
