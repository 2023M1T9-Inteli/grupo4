tool
extends CenterContainer

"""
# PT_BR: Variaveis exportadas
# EN_US: Exported variables
"""

# PT_BR: Inicializa as constantes locais
# EN_US: Initialize local constants
enum LOCATIONS {
	TABLE,
	DRAWER,
	BOSS_TABLE,
}

enum ATTRIBUTES_TYPE {
	 MANUAL_WORK = 0,
	 LOGIC_RAC = 0,
	 ART_THINK = 0,
}

enum SLOTS_TYPE {
	WORK,
	PROFILE,	
}

# PT_BR: Inicializa os sinais
# EN_US: Initialize the signals
signal dropped_item(slot)
signal get_item(slot)

# PT_BR: ID único para o slote
# EN_US: Unique ID for the slot
export(String) var uid = ""

# PT_BR: Quantidade do item, usar com a variável "increment"
# EN_US: Item quantity, use with the "increment" variable
export(int) var qtd = 0 setget _set_qtd 

# PT_BR: Quantidade máxima para o slote, usar com a variável "increment"
# EN_US: Maximum amount for the slot, use with the "increment" variable
export(int) var max_qtd = 1 

# PT_BR: Mostra ou oculta o contador de quantidade
# EN_US: Shows or hides the quantity counter
export(bool) var show_qtd = false setget _set_show_qtd 

# PT_BR: Impede que tire o item do slot
# EN_US: Prevents taking the item out of the slot
export(bool) var can_give = true 

# PT_BR: Transparência do preview
# EN_US: Preview transparency
export(float, 0.0, 1.0) var opacity_preview = 1.0 

# PT_BR: Define a localização do slot
# EN_US: Defines the location of the slot
export(LOCATIONS) var location = LOCATIONS.TABLE setget _set_location

# PT_BR: Define o tipo do slot
# EN_US: Defines the slot type
export(SLOTS_TYPE) var slot_type = SLOTS_TYPE.WORK setget _set_slot_type

# PT_BR: Atributos do item
# EN_US: Item attributes
export(Dictionary) var attributes: Dictionary = ATTRIBUTES_TYPE

# PT_BR: Tamanho do slote
# EN_US: Slot size
export(Vector2) var slot_size: Vector2 = Vector2(32, 32) setget _set_slot_size

# PT_BR: Tamanho das imagens
# EN_US: Images size
export(Vector2) var images_size: Vector2 = Vector2(32, 32) setget _set_image_size

# PT_BR: Tamanho do preview
# EN_US: Preview size
export(Vector2) var preview_size: Vector2 = Vector2(32, 32) setget _set_preview_size

# PT_BR: Imagem do slot na mesa
# EN_US: Slot image in the table
export(Texture) var table_image: Texture = null setget _set_table_image

# PT_BR: Imagem do slot na gaveta
# EN_US: Slot image in the drawer
export(Texture) var drawer_image: Texture = null setget _set_drawer_image

# PT_BR: Imagem do slot na mesa da chefe
# EN_US: Slot image in the boss table
export(Texture) var boss_table_image: Texture = null setget _set_boss_table_image


# PT_BR: Variaveis locais
# EN_US: Local variables
var _mouse_right_button: bool = false
var is_dragging: bool = false

# PT_BR: Funções setGet
# EN_US: setGet Functions
func _set_qtd(new_value) -> void:
	qtd = new_value
	if weakref($Qtd).get_ref():
		$Qtd.text = str(qtd)

func _set_show_qtd(new_value) -> void:
	show_qtd = new_value
	if weakref($Qtd).get_ref():
		$Qtd.set("visible", show_qtd)

func _set_slot_size(new_value) -> void:
	slot_size = new_value
	rect_min_size = slot_size
	rect_size = slot_size
	
func _set_image_size(new_value) -> void:
	images_size = new_value
	
	$TableImage.rect_min_size = images_size
	$TableImage.rect_size = images_size
	
	$DrawerImage.rect_min_size = images_size
	$DrawerImage.rect_size = images_size
	
	$BossTableImage.rect_min_size = images_size
	$BossTableImage.rect_size = images_size

func _set_preview_size(new_value) -> void:
	preview_size = new_value

func _set_slot_type(new_value) -> void:
		slot_type = new_value

func _set_location(new_value) -> void:
	location = new_value
	if weakref($TableImage).get_ref() and weakref($DrawerImage).get_ref() and weakref($BossTableImage).get_ref():
		if location == LOCATIONS.TABLE:
			$TableImage.set("visible", true)
			$DrawerImage.set("visible", false)
			$BossTableImage.set("visible", false)
		elif location == LOCATIONS.DRAWER:
			$TableImage.set("visible", false)
			$DrawerImage.set("visible", true)
			$BossTableImage.set("visible", false)
		elif location == LOCATIONS.BOSS_TABLE:
			$TableImage.set("visible", false)
			$DrawerImage.set("visible", false)
			$BossTableImage.set("visible", true)

func _set_table_image(new_value) -> void:
	table_image = new_value
	if weakref($TableImage).get_ref():
		$TableImage.texture = table_image

func _set_drawer_image(new_value) -> void:
	drawer_image = new_value
	if weakref($DrawerImage).get_ref():
		$DrawerImage.texture = drawer_image

func _set_boss_table_image(new_value) -> void:
	boss_table_image = new_value
	if weakref($BossTableImage).get_ref():
		$BossTableImage.texture = boss_table_image


func _ready():
	# PT_BR: É necessário colocar o mouse filter como ignore, caso o contrário o drag não vai funcionar
	# EN_US: It is necessary to put the mouse filter as ignore, otherwise the drag will not work
	for n in get_children():
		if "mouse_filter" in n:
			n.mouse_filter = MOUSE_FILTER_IGNORE


func _process(_delta):
	# PT_BR: Se a Preview do Control estiver sendo arrastada, ele será ocultado até que o arraste termine 
	# EN_US: If the Preview of the Control is being dragged, it will be hidden until the drag is finished
	self._get_location_node().set("visible", !is_dragging)


func _input(event) -> void:
	# PT_BR: Se clicar com botão direito do mouse
	# EN_US: If you right-click
	if event is InputEventMouseButton:
		# PT_BR: Se soltar o click
	# EN_US: If released click
		if event.is_action_released("click"):
			is_dragging = false



# PT_BR: Uma função para resetar o slote
# EN_US: A function to reset the slot
func _clearSlot() -> void:
	# PT_BR: Coloca os valores padrões
	# EN_US: Sets the default values
	qtd = 0
	uid = ""
	$TableImage.texture = null
	$DrawerImage.texture = null
	$BossTableImage.texture = null
	$Qtd.text = str(qtd)
	attributes = ATTRIBUTES_TYPE

# PT_BR: Não recebe parâmetros. Retorna um node com base na localização
# EN_US: Dont receive parameters. Return a node based on location
func _get_location_node():
	# PT_BR: Se a localização é igual a mesa
	# EN_US: If the location is equal to table
	if location == LOCATIONS.TABLE:
		return self.get_node("TableImage")
		
	# PT_BR: Senão, se a localização é igual a gaveta
	# EN_US: Else if the location is equal to table
	elif location == LOCATIONS.DRAWER:
		return self.get_node("DrawerImage")
	
	# PT_BR: Senão, se a localização é igual a mesa do chefe
	# EN_US: Else if the location is equal to boss table
	elif location == LOCATIONS.BOSS_TABLE:
		return self.get_node("BossTableImage")

""" 
DRAG AND DROP
"""

# PT_BR: Função chamada automaticamente assim que uma ação de drag é identificada
# EN_US: Function called automatically as soon as a drag action is identified
func get_drag_data(_position):
	# PT_BR: Se o item não pode ser tirado retorna falso
	# EN_US: If item cannot by taked return false
	if !can_give: return self
	is_dragging = true
	var preview_pos = -(preview_size / 2)
	
	# PT_BR(1): Preview do item arrastado, duplicando ele mesmo
	# PT_BR(2): Esse item duplicado, só server para o preview, depois ele é descartado automaticamente
	# EN_US(1): Preview of the dragged item, duplicating itself
	# EN_US(2): This duplicate item, only server for the preview, then it is automatically discarded
	var drag_preview = self.duplicate()
	drag_preview.modulate.a = opacity_preview
	
	drag_preview.rect_min_size = preview_size
	drag_preview.rect_size = preview_size	
	drag_preview.get_node("TableImage").rect_min_size = preview_size
	drag_preview.get_node("TableImage").rect_size = preview_size
	drag_preview.get_node("DrawerImage").rect_min_size = preview_size
	drag_preview.get_node("DrawerImage").rect_size = preview_size
	drag_preview.get_node("BossTableImage").rect_min_size = preview_size
	drag_preview.get_node("BossTableImage").rect_size = preview_size
	
	drag_preview.get_node("TableImage").rect_position = preview_pos
	drag_preview.get_node("DrawerImage").rect_position = preview_pos
	drag_preview.get_node("BossTableImage").rect_position = preview_pos
	drag_preview.get_node("Qtd").hide()
	
	# PT_BR: Constrói o preview
	# EN_US: Build the preview
	set_drag_preview(drag_preview)
	
	# PR_BR: Retornar para o can_drop_data / drop
	# EN_US: Return to can_drop_data / drop
	return self


# PT_BR: Essa função valida se tem algum item sendo arrastado em cima desse nó, ela deve retornar "TRUE" ou "FALSE"
# EN_US: This function validates if there is an item being dragged over that node, it must return "TRUE" or "FALSE"
func can_drop_data(_position, data) -> bool:
	if !data["can_give"]: return false
	if data == self: return false
	var ret = false		
		
	# PT_BR: Se o slote for incremental
	# EN_US: If the slot is incremental
	if data["qtd"] == 0:
		return false
		
	# PT_BR: Se o slote tem limite máximo, e já estiver totalmente ocupado
	# EN_US: If the slot has a maximum limit, and is already fully occupied
	if max_qtd != 0 and max_qtd == qtd:
		return false
			
	# PT_BR: Se origem e destino não são do mesmo grupo
	# EN_US: If origin and destination are not from the same group
	if data["slot_type"] != slot_type:
		return false

	# PT_BR: Se a origem e destino possuem o mesmo uid, ou o slote não possui uid
	# EN_US: If the source and destination have the same uid, or the slot has no uid
	if data["uid"] == uid or uid == "":
		ret = true
					
	return ret


# PT_BR: Essa função captura o preview que estava sendo arrastado, e vem no parâmetro "data"
# EN_US: This function captures the preview that was being dragged, and comes in the parameter "data"
func drop_data(_position, data) -> void:
	var qtd_drop = 1
	
	# PT_BR: Incrementa a quantidade
	# EN_US: Increase the amount
	qtd += qtd_drop 
	
	# PT_BR: Atualiza o uid do slote
	# EN_US: Updates the slid uid
	uid = data["uid"] 
	
	# PT_BR: Atualiza a imagem, cor e quantidade do slote que recebeu o item
	# EN_US: Updates the image, color and quantity of the slot that received the item
	drawer_image = data["drawer_image"]
	table_image = data["table_image"] 
	boss_table_image = data["boss_table_image"]
	attributes = data["attributes"]
	$Qtd.text = str(qtd)
	
	# PT_BR: Se a imagem da gaveta dropada tiver uma textura
	# EN_US: If the dropped drawer image has a texture
	if data["drawer_image"] is Texture:
		# PT_BR: Atualiza a textura da imagem da gaveta
		# EN_US: Updates the image drawer texture
		$DrawerImage.texture = data["drawer_image"] 
	else:
		$DrawerImage.texture = null
	
	# PT_BR: Se a imagem da mesa dropada tiver uma textura
	# EN_US: If the dropped table image has a texture
	if data["table_image"] is Texture:
		# PT_BR: Atualiza a textura da imagem da mesa
		# EN_US: Updates the image table texture
		$TableImage.texture = data["table_image"] 
	else:
		$TableImage.texture = null
	
	# PT_BR: Se a imagem da mesa do chefe dropada tiver uma textura
	# EN_US: If the boss table image has a texture
	if data["boss_table_image"] is Texture:
		# PT_BR: Atualiza a textura da imagem na mesa do chefe
		# EN_US: Updates the boss table image texture
		$BossTableImage.texture = data["boss_table_image"] 
	else:
		$BossTableImage.texture = null
	
	# PT_BR: Decrementa a quantidade dropada
	# EN_US: Decreases the amount dropped
	data["qtd"] -= qtd_drop 	
	
	# PT_BR: Se a quantidade for 0, limpa o slote de origem
	# EN_US: If the quantity is 0, clean the original slot
	if data["qtd"] == 0:
		data._clearSlot()
		
	# PT_BR: Atualiza a label de quantidade
	# EN_US: Updates the quantity label
	data.get_node("Qtd").text = str(data["qtd"])
	
	# PT_BR: Envia os sinais relativos ao envio e chegada do item
	# EN_US: Sends the signals regarding the shipment and arrival of the item
	self.emit_signal("get_item", self)
	data.emit_signal("dropped_item", data)
	
	# PT_BR: Atualiza a variável no objeto dropado (origem)
	# EN_US: Updates the variable in the dropped object (source)
	data.is_dragging = false


# PT_BR: Código baseado no seguinte repositório:
# EN_US: Code based on the following repository:
# https://github.com/thiagobruno/godot_dragndrop.git
