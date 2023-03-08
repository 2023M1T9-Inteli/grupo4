extends Node2D

signal kira_fineshed_task(worker)
signal roger_fineshed_task(worker)
signal bento_fineshed_task(worker)
signal ana_fineshed_task(worker)

onready var kira = $Kira
onready var roger = $Roger
onready var bento = $Bento
onready var ana = $Ana

func _on_Kira_finished_task(worker):
	emit_signal("kira_fineshed_task", worker)


func _on_Roger_finished_task(worker):
	emit_signal("roger_fineshed_task", worker)


func _on_Bento_finished_task(worker):
	emit_signal("bento_fineshed_task", worker)


func _on_Ana_finished_task(worker):
	emit_signal("ana_fineshed_task", worker)

func Kira_initiate_task(task):
	kira.initiate_task(task)

func Roger_initiate_task(task):
	roger.initiate_task(task)

func Bento_initiate_task(task):
	bento.initiate_task(task)

func Ana_initiate_task(task):
	ana.initiate_task(task)
