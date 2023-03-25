extends Node2D

# PT_BR: Inicializa os sinais usados para passar de cena do tutorial.
# EN_US: Initializes the signals used to pass the tutorial scene.
signal next_tutorial()
signal end_tutorial()

# PT_BR: Sinal customizado que detecta quando o botão de pular é pressionado.
# EN_US: Custom signal that detects when the skip button is pressed.
func _on_skip_button_pressed():
	emit_signal("end_tutorial")

# PT_BR: Sinal customizado que detecta quando o botão de avançar é pressionado.
# EN_US: Custom signal that detects when the next button is pressed.
func _on_next_button_pressed():
	emit_signal("next_tutorial")




