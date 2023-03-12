extends TextureRect
# PT_BR: Declaram o tempo  
# EN_US: Declare the time 
export var seconds = 15
export var  minutes = 4
# PT_BR:Ultilizado se caso o tempo acabar  
# EN_US: It will be used if the time runs out 
signal timer_is_over()
# PT_BR: Cronometro 
# EN_US: stopwatch
func _on_Timer_timeout():
	seconds -= 1
	if seconds < 0:
			minutes -= 1
			seconds = 59
# PT_BR: criam uma string formatada que mostra o tempo restante do temporizador no formato
# EN_US: create a formatted string that shows the remaining time of the timer in format
	var format_string = "[color=#e01f28]%02d:%02d[/color]" % [minutes, seconds]
	$RichTextLabel.bbcode_text = format_string
# PT_BR: Quando o tempo acabar emitir um sinal que o tempo acabou
# EN_US: When the time run out it will send a signal that the time is over
	if seconds == 0 and minutes == 0:
		self.emit_signal("timer_is_over")
