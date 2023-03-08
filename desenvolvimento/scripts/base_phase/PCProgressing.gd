extends TextureProgress

signal completed_change()

func increase_value():
	self.value += 9
	if self.value == 81:
		emit_signal("completed_change")
