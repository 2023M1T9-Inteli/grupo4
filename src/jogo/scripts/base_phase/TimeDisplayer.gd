extends TextureRect

# PT_BR: Declara o segundos e minutos do cronometro
# EN_US: Declare the cronometer seconds and minutes
export var seconds = 15
export var  minutes = 4

# PT_BR: Sinal enviado quando o tempo se esgotar
# EN_US: Signal sended when the time runs out.
signal timer_is_over()

func _on_Timer_timeout():
	seconds -= 1
	
	# PT_BR: Se o segundos for menor que 0
	# EN_US: If seconds is less than 0
	if seconds < 0:
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
