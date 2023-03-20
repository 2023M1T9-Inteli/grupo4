tool
extends TextureProgress

# PT_BR: Sinal para quando avisar completar a barra de progresso
# EN_US: Signal emitted when the progress bar is completed
signal completed_change()

var value_to_increase = 10

export var qtd_task = 10 setget _set_qtd_task

func _set_qtd_task(new_value) -> void:
	qtd_task = new_value
	self.max_value = float(qtd_task * qtd_task)
	value_to_increase = qtd_task


# PT_BR: Função para aumentar o valor da barra de progresso
# EN_US: Function to increase progress bar value
func increase_value():
	# PT_BR: Aumenta o valor da propriedade value da barra de progresso em 9 unidades.
	# EN_US: Increases the value of the progress bar's value property by 9
	self.value += value_to_increase
	
	# PT_BR: Se o valor atual da barra de progresso é igual a 81.
	# EN_US: If the current progress bar value is equal to 81.
	if self.value == self.max_value:
		# PT_BR: Emite o sinal que a barra de progresso atingiu 100%.
		# EN_US: Emit the signal that the progress bar has reached 100%.
		emit_signal("completed_change")
		
