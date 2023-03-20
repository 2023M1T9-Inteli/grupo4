extends Node2D

export var is_in_menu = true

var file_scene = preload("res://scenes/tutorial/File_explanning.tscn")
var task_scene = preload("res://scenes/tutorial/Task_introduction.tscn")

func end_tutorial():
	if is_in_menu:
		get_tree().change_scene("res://scenes/Phases.tscn")
	else:
		for child in self.get_children():
			child.hide()
		self.hide()

func create_file():
	var file_instance = file_scene.instance()
	self.add_child(file_instance)
	file_instance.connect("back_tutorial", self,"_on_file_back_tutorial")
	file_instance.connect("next_tutorial", self, "_on_file_next_tutorial")
	
func create_task():
	var task_instance = task_scene.instance()
	self.add_child(task_instance)
	task_instance.connect("back_tutorial", self,"_on_task_back_tutorial")
	task_instance.connect("next_tutorial", self, "_on_task_next_tutorial")

func _input(event):
	if event.is_action_pressed("home"):
		get_tree().quit()

func open_tutorial():
	$introduction.show()
	self.show()

func _on_introduction_next_tutorial():
	$introduction.hide()
	$skip.show()

func _on_introduction_back_tutorial():
	$introduction.hide()
	self.hide()

func _on_skip_next_tutorial():
	$skip.hide()
	$paula.show()

func _on_paula_next_tutorial():
	$paula.hide()
	create_file()

func _on_paula_back_tutorial():
	$paula.hide()
	$skip.show()

func _on_file_next_tutorial(file):
	file.queue_free()
	create_task()

func _on_file_back_tutorial(file):
	file.queue_free()
	$paula.show()	

func _on_task_next_tutorial(task):
	task.queue_free()
	$score.show()

func _on_task_back_tutorial(task):
	task.queue_free()
	create_file()

func _on_score_next_tutorial():
	end_tutorial()

func _on_score_back_tutorial():
	$score.hide()
	create_task()

func _on_skip_end_tutorial():
	end_tutorial()
