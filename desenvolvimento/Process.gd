extends Node2D
onready var timer = $Timer

const ATRIBUTES: Dictionary = {
	 "manual_work": 1,
	 "logic_rac": 2,
	 "art_think": 3
}

const VALUES: Dictionary = {
	1: 10,
	2: 20,
	3: 30
}
func _on_Button_pressed():
	joger_tarefa("manual_work")
# attr = "manual_work"
func joger_tarefa(attr):
	var choiced_attr = [attr]
	if ATRIBUTES == VALUES:
		timer.start()
	pass # Replace with function body.
