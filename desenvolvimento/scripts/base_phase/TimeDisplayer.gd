extends TextureRect

export var seconds = 15
export var  minutes = 4

signal timer_is_over()

func _on_Timer_timeout():
	seconds -= 1
	if seconds < 0:
			minutes -= 1
			seconds = 59
		
	var format_string = "[color=#e01f28]%02d:%02d[/color]" % [minutes, seconds]
	$RichTextLabel.bbcode_text = format_string
		
	if seconds == 0 and minutes == 0:
		self.emit_signal("timer_is_over")
