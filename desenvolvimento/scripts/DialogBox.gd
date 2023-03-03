extends NinePatchRect

onready var text_element := $Text
onready var timer := $Timer

var counter = 0

var msg_queue: Dictionary = {
	0: {
			"text": "Rosaline: Olá, tudo bem?",
			"anim": "idle",
			"showPC": false,
		},
	1: {
			"text": "Rosaline: Meu nome é Rosaline, sou Chief Operating Officer da minha empresa, e estou aqui pois necessito de seus serviços. ",
			"anim": "idle",
			"showPC": false,
		}, 
	2: {
			"text": "Rosaline: Tenho um grande projeto a ser realizado, de extrema urgência!",
			"anim": "idle",
			"showPC": false,
		},
	3: {
			"text": "Rosaline: Minha empresa está trabalhando no desenvolvimento de novos hardwares para comercialização.",
			"anim": "arm_up",
			"showPC": true,
		},
	4: {
			"text": "Rosaline: Mesmo com bom ritmo de trabalho, estamos atrasados e acreditamos que a sua empresa poderá nos auxiliar em acelerar esse processo.",
			"anim": "idle",
			"showPC": false,
		},
	5: {
			"text": "Rosaline: Mesmo com bom ritmo de trabalho, estamos atrasados e acreditamos que a sua empresa poderá nos auxiliar em acelerar esse processo.",
			"anim": "idle",
			"showPC": false,
		}
	}


func change_speech(speech, anim):
	text_element.visible_characters = 0
	text_element.bbcode_text = speech
	self.get_parent().change_anim(anim)


func _input(event):
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		show_message()


func show_message() -> void:
	if not timer.is_stopped():
		text_element.visible_characters = text_element.bbcode_text.length()
	else:
		if counter == ( len(msg_queue) - 1 ):
			get_tree().change_scene("res://scenes/ConceptScene.tscn")
			return
		
		var write_text = msg_queue[counter]["text"]
		var anim = msg_queue[counter]["anim"]
		var show_pc = msg_queue[counter]["showPC"]
		change_speech(write_text, anim)
		self.get_parent().show_pc(show_pc)
		timer.start()
		counter += 1


func _on_Timer_timeout():
	if text_element.visible_characters == text_element.bbcode_text.length():
		timer.stop()
	text_element.visible_characters += 2
