extends Control

# PT_BR: Abre a cena do menu.
# EN_US: Open the menu scene.
func _on_BackButton_pressed():
	self.hide()


#PT_BR: Essas funções abrem os perfis do linkedin de cada integrante
#EN_US: These functions open the linkedin profiles of each member
func _on_YanLinkedin_pressed():
	OS.shell_open("")


func _on_RaphaLinkedin_pressed():
	OS.shell_open("https://www.linkedin.com/in/heitorprudente/")


func _on_RaissaLinkedin_pressed():
	OS.shell_open("https://www.linkedin.com/in/raissa-vieira-de-melo/")


func _on_HeitorLinkedin_pressed():
	OS.shell_open("https://www.linkedin.com/in/heitorprudente/")


func _on_PedroLinkedin_pressed():
	OS.shell_open("https://www.linkedin.com/in/pedro-bannwart-0565aa264/")


func _on_CaioLinkedin_pressed():
	OS.shell_open("https://www.linkedin.com/in/caio-paula-36b187264/")


func _on_HenriqueLinkedin_pressed():
	OS.shell_open("")

