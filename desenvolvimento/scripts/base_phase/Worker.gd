extends Node2D

enum ATTRIBUTES_TYPE {
	 MANUAL_WORK = 3,
	 LOGIC_RAC = 0,
	 ART_THINK = 0,
}

export(Vector2) var worker_size: Vector2 = Vector2(32, 32) setget _set_worker_size

export(Texture) var worker_image: Texture = null setget _set_worker_image

export(Dictionary) var attributes: Dictionary = ATTRIBUTES_TYPE

func _set_worker_image(new_value) -> void:
	worker_image = new_value
	if weakref($Worker).get_ref():
		$Worker.texture = worker_image

func _set_worker_size(new_value) -> void:
	worker_size = new_value
	$Worker.rect_min_size = worker_size
	$Worker.rect_size = worker_size

var score = 0
onready var timer = $Timer
onready var cronometer = $Cronometer

signal finished_task(worker)

func initiate_task(task):
	_compare_attributes(task["attributes"])
	cronometer.value = 0
	cronometer.show()
	timer.start()


func _compare_attributes(task_attributes: Dictionary):
	var comparedAttr = 0
	for key in task_attributes.keys():
		comparedAttr += attributes[key] - task_attributes[key]
	score = 100 + comparedAttr * 10


func _on_Timer_timeout():
	if cronometer.value < 100:
		cronometer.value += 1
	else:
		timer.stop()
		cronometer.hide()
		emit_signal("finished_task", self)
