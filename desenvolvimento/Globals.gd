extends Node

# PT_BR: Inicializa as constantes para exportar como variáveis em outras cenas
# EN_US: Initialize constants for export them as variables in other scenes
enum PHASES {
	PHASE_1 = 1,
	PHASE_2 = 2,
	PHASE_3 = 3,
}


# PT_BR: Inicializa a constante para navegar entre os dicionários
# EN_US: Initializes tue constant for navigating between the dictionaries
const phases_keys = {
	1: "phase1",
	2: "phase2",
	3: "phase3",
}


# PT_BR: Inicializa a constante das pontuações máximas
# EN_US: Initializes max score constant
const phases_max_score = {
	"phase1": 1500,
	"phase2": 1800,
	"phase3": 10,
}

# PT_BR: Inicializa a variável para guardar a maior pontuação feita pelo usuário
# EN_US: Initializes the variable to store the max score made by the User
var player_phase_score = {
	"phase1": 0,
	"phase2": 0,
	"phase3": 0,
}

# PT_BR: Inicializa a variável para guardar o score atual
# EN_US: Initializes the variable to store the actual score
var actual_score = 0

# PT_BR: Inicializa a variável para guardar o fase atual
# EN_US: Initializes the variable to store the actual phase
var actual_phase = PHASES.PHASE_1

# PT_BR: Inicializa a variável de controle para verificar se o usuário perdeu por tempo
# EN_US: Initializes the control variable to check if the user lose by time
var lose_by_time = false

# PT_BR: Inicializa a variável de controle para o volume da música
# EN_US: Initializes the control variable for music volume
var music_volume

# PT_BR: Inicializa a variável de controle para o volume dos efeitos
# EN_US: Initializes the control variable for effects volume
var effects_volume

# PT_BR (1): Função que atualiza o score atual
# PT_BR (2): Recebe new_value para atualizar o valor do score: int 
# EN_US (1): Function that updates the current score 
# EN_US (2): Receives new_value to update the score value: int
func set_actual_score(new_value: int):
	actual_score = new_value


# PT_BR (1): Função que atualiza a fase atual
# PT_BR (2): Recebe new_value para atualizar a fase do score: int enum PHASES
# EN_US (1): Function that updates the phase score 
# EN_US (2): Receives new_value to update the phase value: int enum PHASES
func set_actual_phase(new_value := PHASES.PHASE_1):
	actual_phase = new_value

