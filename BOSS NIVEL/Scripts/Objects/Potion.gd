extends CharacterBody2D

@export var speed: float = 50.0
@export var change_interval: float = 2.0
@export var slowdown_factor: float = 0.5

# Variables internas
var direction: Vector2 = Vector2.ZERO
var time_until_change: float = 0.0
var initial_position: Vector2

func _ready():
	initial_position = global_position
	set_random_direction()

func _physics_process(delta: float) -> void:
	time_until_change -= delta
	if time_until_change <= 0:
		set_random_direction()
	
	# Calcula la nueva posición potencial
	var new_position = global_position + (direction * speed * slowdown_factor * delta)
	
	# Verifica si la nueva posición está dentro del límite de 100 píxeles desde la posición inicial
	if new_position.distance_to(initial_position) <= 100.0:
		# Mueve el objeto en la dirección actual con la velocidad especificada
		velocity = direction * speed * slowdown_factor
	else:
		# Si se sale del límite, cambia la dirección
		set_random_direction()
		velocity = Vector2.ZERO

	move_and_slide()

func set_random_direction():
	var angle = randf() * TAU  # TAU es equivalente a 2 * PI
	direction = Vector2(cos(angle), sin(angle)).normalized()
	time_until_change = change_interval

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		var random_number = randf()
		var lives = 0
		if random_number < 0.6:
			lives = 1
		elif random_number < 0.9:  # Si el número es mayor a 0.6 pero menor a 0.9, imprime 2
			lives = 2
		else:  # Si el número es mayor a 0.9, imprime 3
			lives = 3
		area.get_parent().add_health(lives)
		
		queue_free()
