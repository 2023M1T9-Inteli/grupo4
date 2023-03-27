extends Node

enum PHASES {
	PHASE_1 = 0,
	PHASE_2 = 1,
	PHASE_3 = 3,
}

const phases_keys = [
	"phase1",
	"phase2",
	"phase3",
]

const phases_max_score = {
	"phase1": 1500,
	"phase2": 1800,
	"phase3": 0,
}

var player_phase_score = {
	"phase1": 0,
	"phase2": 0,
	"phase3": 0,
}

var actual_score = 0
var actual_phase = PHASES.PHASE_1

var lose_by_time = false

var music_volume
var effects_volume


func set_actual_score(new_value: int):
	actual_score = new_value


func set_actual_phase(new_value := PHASES.PHASE_1):
	actual_phase = new_value
	

func set_player_phase_score(phase: String, new_value: int):
	player_phase_score[phase] = new_value
