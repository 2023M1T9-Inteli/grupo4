tool
extends TextureProgress

# PT_BR: Sinal para quando avisar completar a barra de progresso
# EN_US: Signal emitted when the progress bar is completed
signal completed_change()

# PT_BR: Variável que armazena o valor padrão usado para aumentar a barra de progresso.
# EN_US: Variable that stores the default value used to increase the progress bar. 
var value_to_increase = 10

# PT_BR: Variável que armazena a quantidade de tarefas na fase.
# EN_US: Variable that stores the quantity of tasks in the phase.
export var qtd_task = 10 setget _set_qtd_task

# PT_BR: Atualiza o valor máximo da barra de progresso de acordo com a quantidade de tarefas.
# EN_US: Updates the maximum value of the progress bar according to the quantity of tasks.
func _set_qtd_task(new_value) -> void:
	qtd_task = new_value
	self.max_value = float(qtd_task * qtd_task)
	value_to_increase = qtd_task


# PT_BR: Função para aumentar o valor da barra de progresso
# EN_US: Function to increase progress bar value
func increase_value():
	# PT_BR: Aumenta o valor da propriedade value da barra de progresso.
	# EN_US: Increases the value of the progress bar's value property
	self.value += value_to_increase
	
	# PT_BR: Se o valor atual da barra de progresso é igual ao valor máximo.
	# EN_US: If the current progress bar value is equal to max value.
	if self.value == self.max_value:
		# PT_BR: Emite o sinal que a barra de progresso atingiu 100%.
		# EN_US: Emit the signal that the progress bar has reached 100%.
		emit_signal("completed_change")
		
