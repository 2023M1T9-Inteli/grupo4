extends Node2D

onready var phase_progress = $PhaseProgress

var score = 0

enum ATTRIBUTES_TYPE {
	 MANUAL_WORK = 2,
	 LOGIC_RAC = 2,
}


export(Dictionary) var attributes: Dictionary = ATTRIBUTES_TYPE


func _on_Button2_pressed():
	$Worker.initiate_task(self)


func _on_Worker_finished_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)


func _change_score(new_value): 
	score += new_value
	$ScoreLabel.text = "Score: %0000006d" % score


func _on_TimeDisplayer_timer_is_over():
	get_tree().change_scene("res://scenes/base_phase/Defeat.tscn")


func _on_PhaseProgress_completed_change():
	get_tree().change_scene("res://scenes/base_phase/Victory.tscn")
