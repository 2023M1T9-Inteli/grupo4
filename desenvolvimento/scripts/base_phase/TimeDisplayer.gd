tool
extends TextureRect

# PT_BR: Declara o segundos e minutos do cronometro
# EN_US: Declare the cronometer seconds and minutes
export(int) var seconds = 30 setget _set_seconds
export(int) var minutes = 4 setget _set_minutes
var counter = 0

# PT_BR (1): Funções para definir as variáveis. 
# PT_BR (2): Parâmetro: new_value
# EN_US (1): Functions to set variables. 
# EN_US (2): Parameter: new_value
func _set_seconds(new_value):
	seconds = new_value
	if weakref($RichTextLabel).get_ref():
		var format_string = "[color=#e01f28]%02d:%02d[/color]" % [minutes, seconds]
		$RichTextLabel.bbcode_text = format_string


func _set_minutes(new_value):
	minutes = new_value
	if weakref($RichTextLabel).get_ref():
		var format_string = "[color=#e01f28]%02d:%02d[/color]" % [minutes, seconds]
		$RichTextLabel.bbcode_text = format_string


# PT_BR: Sinal enviado quando o tempo se esgotar
# EN_US: Signal sended when the time runs out.
signal timer_is_over()
	

func _on_Timer_timeout():
	seconds -= 1
	
	# PT_BR: Se o segundos for menor que 0
	# EN_US: If seconds is less than 0
	if seconds < 0:
		# PT_BR: Se o minuto for igual a 1
		# EN_US: If minutes equals 1
		if minutes == 1:
			blink_blink()
			
			# PT_BR: Toca o som de tempo passando
			# EN_US: Plays time passing sound	
			$TimePassing.play()
			
		# PT_BR: Diminui um minuto e adiciona 59 segundos
		# EN_US: Decreases a minute and increase 59 seconds
		minutes -= 1
		seconds = 59

	# PT_BR: Atualiza o tempo do temporizador com uma string formatada
	# EN_US: Update the cronometer time with a formated string
	var format_string = "[color=#e01f28]%02d:%02d[/color]" % [minutes, seconds]
	$RichTextLabel.bbcode_text = format_string
	
	# PT_BR: Se segundos e minutos são iguais a 0
	# EN_US: If seconds and minutes are equals to 0
	if seconds == 0 and minutes == 0:
		# PT_BR: Emite o sinal que o tempo acabaou
		# EN_US: Emits the signal that time is over
		self.emit_signal("timer_is_over")


# PT_BR: Essa função faz o display piscar
# EN_US: This function makes the display blink
func blink_blink():
	for i in range(6):
		if i % 2 == 1:
			self.modulate.a = 1
		else:
			self.modulate.a = 0
			
		yield(get_tree().create_timer(0.25),"timeout")
