extends TextureProgress

signal completed_change(texture_progress_node)

func change_value(add_value):
	self.value += add_value
	
	if self.value >= self.max_value:
		emit_signal("completed_change", self)
