extends CharacterBody2D

@export var speed: float = 50.0
@export var change_interval: float = 2.0
@export var slowdown_factor: float = 0.5

@export var speed_increase_probs: Dictionary = {
	"low": 0.5,  # 50% de probabilidad de aumentar la velocidad en 10
	"medium": 0.3,  # 30% de probabilidad de aumentar la velocidad en 20 
	"high": 0.2  # 20% de probabilidad de aumentar la velocidad en 30
}

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
	
	# Verifica si la nueva posición está dentro del límite de 50 píxeles desde la posición inicial
	if new_position.distance_to(initial_position) <= 50.0:
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
		var speed = 0
		if random_number < speed_increase_probs["low"]:
			print("Aumenta la velocidad en 10")
			speed = 10.0
		elif random_number < speed_increase_probs["low"] + speed_increase_probs["medium"]:
			print("Aumenta la velocidad en 20")
			speed = 20.0
		else:
			print("Aumenta la velocidad en 30")
			speed = 30.0
		area.get_parent().increase_speed(speed)
		queue_free()
