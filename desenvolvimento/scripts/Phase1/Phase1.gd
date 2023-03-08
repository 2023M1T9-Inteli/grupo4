extends Node2D

onready var phase_progress = $PhaseProgress

var score = 0

onready var slot_kira = $SlotExpansorKira/SlotCollectionKira/WorkSlotKira
onready var slot_roger = $SlotExpansorRoger/SlotCollectionRoger/WorkSlotRoger
onready var slot_ana = $SlotExpansorAna/SlotCollectionAna/WorkSlotAna
onready var slot_bento = $SlotExpansorBento/SlotCollectionBento/WorkSlotBento


func _change_score(new_value): 
	score += new_value
	$ScoreLabel.text = "Score: %0000006d" % score


func _on_TimeDisplayer_timer_is_over():
	get_tree().change_scene("res://scenes/base_phase/Defeat.tscn")


func _on_PhaseProgress_completed_change():
	get_tree().change_scene("res://scenes/base_phase/Victory.tscn")


func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")


func _on_Map_ana_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_ana._clearSlot()
	slot_ana.can_give = true


func _on_Map_bento_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_bento._clearSlot()
	slot_bento.can_give = true


func _on_Map_kira_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_kira._clearSlot()
	slot_kira.can_give = true


func _on_Map_roger_fineshed_task(worker):
	phase_progress.increase_value()
	_change_score(worker.score)
	slot_roger._clearSlot()
	slot_roger.can_give = true


func _on_workSlotKira_get_item(slot):
	print("get_item: ", slot, "\n")
	slot.can_give = false
	$Map.Kira_initiate_task(slot)


func _on_workSlotRoger_get_item(slot):
	slot.can_give = false
	$Map.Roger_initiate_task(slot)


func _on_workSlotBento_get_item(slot):
	slot.can_give = false
	$Map.Bento_initiate_task(slot)


func _on_workSlotAna_get_item(slot):
	slot.can_give = false
	$Map.Ana_initiate_task(slot)
