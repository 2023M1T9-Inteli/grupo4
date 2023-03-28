extends NinePatchRect

# PT_BR: Variáveis locais
# EN_US: Local variables
onready var text_element := $Text
onready var timer := $Timer
var counter = 0

signal finished_dialog()
signal exit_dialog()
func _ready():
	show_message(0)
# PT_BR: Dicionário de falas da introdução da primeira fase
# EN_US: Speech dictionary fot the first level introduction
var message_queue: Dictionary = {
	0: {
			"text": "[color=#368E69]Xarmes[/color]: Socorro! Está tudo acabado!",
			"anim": "idle",
			"showGift": false,
			"showBento": false,
		},
	1: {
			"text": "[color=#368E69]Xarmes[/color]: Ei você! Meu nome é Xarmes, o duende de natal, e preciso da sua ajuda urgentemente!",
			"anim": "idle",
			"showGift": false,
			"showBento": false,
		},
	2: {
			"text": "[color=#368E69]Xarmes[/color]: O papai noel sumiu, e não sabemos o que vamos fazer! Sem ele, o natal está arruinado e as crianças vão ficar sem seus presentes!",
			"anim": "arm_up",
			"showGift": true,
			"showBento": false,
		}, 
	3: {
			"text": "[color=#368E69]Xarmes[/color]: Vocês são os melhores para me ajudar nessa situação, pois temos que ser rápidos para salvar esse natal!",
			"anim": "idle",
			"showGift": false,
			"showBento": false,
		},
	4: {
			"text": "[color=#368E69]Xarmes[/color]: Porém, teremos que trabalhar com pessoal reduzido pois alguém tem que assumir o lugar do papai noel, então seu funcionário Bento terá de assumir essa responsabilidade!",
			"anim": "arm_up",
			"showGift": false,
			"showBento": true,
		},
	5: {
			"text": "[color=#368E69]Xarmes[/color]: Chega de conversa e mãos a obra!",
			"anim": "idle",
			"showGift": false,
			"showBento": false,
		},
	6: {
			"text": "",
			"anim": "idle",
			"showGift": false,
			"showBento": false,
		}
	}

# PT_BR: Função que apaga o texto anterior e executa a função de mudança de sprite da personagem
# EN_US: Function that erases the anterior text and executes the function of sprite change for the character
func change_speech(speech, anim):
	text_element.visible_characters = 0
	text_element.bbcode_text = speech
	self.get_parent().change_anim(anim)

# PT_BR: Função que define que após pressionado o botão esquerdo do mouse, a função "show_message" é executada
# EN_US: Function that defines that after the button of the mouse is pressed, the function "show_message" is executed
func _on_PassButton_pressed():
		show_message(1)

# PT_BR: Função que verifica se o texto exibido na tela é o mesmo que o dentro do item do dicionário.
# EN_US: Function that verifies if the text on screen is the same as the inside the dictionary item.
func show_message(update_counter) -> void:
	# PT_BR(1): Se o timer não estiver parado, o texto na tela deve progredir para que alcance o mesmo tamanho do elemento
	# PT_BR(2): contido no dicionário
	# EN_US(1): If the timer is not stopped, the text on sreen needs to progreed until it reaches the same size as the element 
	# EN_US(2): in the dicitionary
	if not timer.is_stopped():
		text_element.visible_characters = text_element.bbcode_text.length()
	else:
		counter += update_counter
		# PT_BR: Se o timer parar e o texto já tiver atingido seu tamanho, ele deve mudar para a próxima cena definida
		# EN_US: If the timer stops and the text reached it's limit, it needs to change to the next defined scene
		if counter == ( len(message_queue) - 1 ):
			emit_signal("finished_dialog")
			return
		elif counter < 0:
			emit_signal("exit_dialog")
			return
		# PT_BR: Variáveis que contém o texto, animações e a imagem do sprite, associando os mesmos a itens na lista
		# EN_US(1): Variables that have the text, animations and images from the sprite, merging them with the itens in
		# EN_US(2): the list
		var write_text = message_queue[counter]["text"]
		var anim = message_queue[counter]["anim"]
		var show_gift = message_queue[counter]["showGift"]
		var show_bento = message_queue[counter]["showBento"]
		change_speech(write_text, anim)
		self.get_parent().show_gift(show_gift)
		self.get_parent().show_bento(show_bento)
		timer.start()

# PT_BR: Função que define a exibição do texto caracter por caracter e para o timer
# EN_US: Function that defines the text exibition character per character and stops the timer
func _on_Timer_timeout():
# PT_BR: Se o texto visível for igual ao limite do alcance do texto, o timer para 
# EN_US: If the visible text is equal to the limite of the text range, the timer stops
	if text_element.visible_characters == text_element.bbcode_text.length():
		timer.stop()
		# PT_BR: Aumenta o numero de caracteres visíveis na tela
		# EN_US: Raises the number of charactesr visible on the screen
	text_element.visible_characters += 2

func _on_BackButton_pressed():
	show_message(-1)
