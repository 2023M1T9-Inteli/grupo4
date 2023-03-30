extends TextureProgress

# PT_BR (1): Criação do sinal personalizado.
# PT_BR (2): Recebe texture_progress_node como parâmetro
# EN_US (1): Custom sign creation.
# EN_US (2): Receives texture_progress_node as parameter
signal completed_change(texture_progress_node)

# PT_BR (1): Função que adiciona um valor e emite um sinal caso a barra esteja preenchida.
# PT_BR (2): Recebe o objeto add_value como parâmetro
# EN_US (1): Function that adds a value and issues a signal if the bar is filled.
# EN_US (2): Receives the add_value object as parameter
func change_value(add_value):
	self.value += add_value
	
	if self.value >= self.max_value:
		emit_signal("completed_change", self)
