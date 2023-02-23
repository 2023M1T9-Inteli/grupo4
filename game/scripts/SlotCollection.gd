tool
extends HBoxContainer

"""
# PT_BR: Variaveis exportadas
# EN_US: Exported variables
"""

# PT_BR: Tamanho da coleção de slote
# EN_US: Slot Collection size
export(Vector2) var size: Vector2 = Vector2(64, 64) setget _set_size

# PT_BR: Funções para definir as variavéis
# EN_US: Functions to set variables
func _set_size(newValue) -> void:
	size = newValue
	self.rect_min_size = size
	self.rect_size = size
	self.margin_bottom = 0
	self.margin_left = 0
	self.margin_right = 0
	self.margin_top = 0

# PT_BR: Inicializa as variaveis locais
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
		if child is Control:
			qtd_control_children += 1
			total_children_size += child.size.x
			
	_change_separation_to_space_between(qtd_control_children, total_children_size, size.x)

# PT_BR: Divide o espaço do Slot Collection igualmente entre os nós Control
# EN_US: Divide Slot Collection space equally between controls nodes
func _change_separation_to_space_between(qtd_childs, total_children_size, container_size):
	var space_between =  (container_size - total_children_size) / (qtd_childs - 1)
	self.add_constant_override("separation", space_between)

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
	var size_x_per_children = (size.x) / qtd_control_children
	var actual_child = 0
	for child in self.get_children():
		if child is Control:
			var min_position = size_x_per_children * (actual_child)
			var max_position = size_x_per_children * (actual_child + 1)
			if min_position <= position.x and position.x <= max_position:
				return child.get_drag_data(position)
			actual_child += 1

# PT_BR: Verifica se algum Control filho aceita o objeto que está sendo arrastado e retorna o resultado
# EN_US: Checks if any child Control accepts the object being dragged and returns the result
func can_drop_data(position, data) -> bool:
	var can_drop = false
	for child in self.get_children():
		if child is Control:
			can_drop = can_drop or child.can_drop_data(position, data)
	return can_drop

# PT_BR: Checa qual dos Controls filhos aceita o objeto e, ao achar, o envia o objeto arrastado para o Control
# EN_US: Checks which of the child Controls accepts the object and, when found, sends the dragged object to the Control
func drop_data(position, data) -> void:
	for child in self.get_children():
		if child is Control and child.can_drop_data(position, data):
			child.drop_data(position, data)
			return
