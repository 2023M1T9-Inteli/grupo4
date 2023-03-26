extends TextureProgress

# PT_BR: Criação do sinal personalizado.
# # EN_US: Custom sign creation.
signal completed_change(texture_progress_node)

# PT_BR: Função que adiciona um valor e emite um sinal caso a barra esteja preenchida.
# EN_US: Function that adds a value and issues a signal if the bar is filled.
func change_value(add_value):
	self.value += add_value
	
	if self.value >= self.max_value:
		emit_signal("completed_change", self)
