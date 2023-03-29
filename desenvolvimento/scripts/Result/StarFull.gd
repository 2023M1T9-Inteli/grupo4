extends TextureProgress

# PT_BR: Criação do sinal personalizado.
# # EN_US: Custom sign creation.
signal completed_change(texture_progress_node)

# PT_BR (1): Função que adiciona um valor e emite um sinal caso a barra esteja preenchida.
# PT_BR (2): Recebe o objeto add_value como parâmetro
# EN_US (1): Function that adds a value and issues a signal if the bar is filled.
# EN_US (2): Receives the add_value object as parameter
func change_value(add_value):
	self.value += add_value
	
	if self.value >= self.max_value:
		emit_signal("completed_change", self)
