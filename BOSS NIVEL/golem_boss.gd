extends CharacterBody2D

@onready var player = get_parent().find_child("player")
@onready var sprite = $Sprite2D
@onready var progress_bar = $UI/ProgressBar

var direction : Vector2
var DEF = 0

var health = 100

var current_direction = Vector2.RIGHT # Dirección inicial del jefe

# Matriz de transición para la cadena de Markov
var transition_matrix = {
	Vector2.LEFT: [0.5, 0.5],  
	Vector2.RIGHT: [0.5, 0.5]
}

func _ready():
	set_physics_process(false)

func _process(_delta):
	direction = player.position - position

	if direction.x < 0:
		sprite.flip_h = true
		current_direction = Vector2.LEFT  # Actualiza la dirección actual del jefe cuando el jugador está a la izquierda
	else:
		sprite.flip_h = false
		current_direction = Vector2.RIGHT  # Actualiza la dirección actual del jefe cuando el jugador está a la derecha

func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)

func take_damage():
	health -= 10 - DEF

# Función para elegir la próxima dirección del jefe utilizando la cadena de Markov
func choose_next_direction(current_direction):
	var probabilities = transition_matrix[current_direction]
	var next_index = weighted_random_choice(probabilities)
	if next_index == 0:
		return Vector2.LEFT
	else:
		return Vector2.RIGHT

# Función auxiliar para elegir una opción ponderada aleatoria
func weighted_random_choice(probabilities):
	var rand = randf()
	var cumulative_prob = 0
	for i in range(probabilities.size()):
		cumulative_prob += probabilities[i]
		if rand < cumulative_prob:
			return i
	return probabilities.size() - 1

# En la lógica del jefe, actualiza la dirección utilizando la cadena de Markov
func update_boss_movement():
	current_direction = choose_next_direction(current_direction)
	if current_direction == Vector2.LEFT:
		direction.x = -1
	else:
		direction.x = 1
