extends Node2D

# PT_BR: Inicializa os sinais usados para passar de cena do tutorial.
# EN_US: Initializes the signals used to pass the tutorial scene.
signal next_tutorial()
signal back_tutorial()


# PT_BR: Sinal customizado que detecta quando o botão de avançar é pressionado.
# EN_US: Custom signal that detects when the next button is pressed.
func _on_next_button_pressed():
	emit_signal("next_tutorial")


# PT_BR: Sinal customizado que detecta quando o botão de voltar é pressionado.
# EN_US: Custom signal that detects when the back button is pressed.
func _on_back_button_pressed():
	emit_signal("back_tutorial")
