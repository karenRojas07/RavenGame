extends Node
extends Node2D
# Variables del jefe
var health = 100
var attack_interval = 30 # 30 segundos
var attack_count = 0
var last_attack_time = 0.0

signal special_attack()

func _ready():
	# Configurar el temporizador de ataque especial
	var timer = Timer.new()
	timer.set_wait_time(attack_interval)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "_on_attack_interval_timeout")
	add_child(timer)
	timer.start()

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()
	else:
		check_special_attack()

func check_special_attack():
	var current_time = OS.get_ticks_msec() / 1000.0 # Obtener el tiempo actual en segundos
	if (current_time - last_attack_time) <= attack_interval:
		attack_count += 1
	else:
		attack_count = 1
	
	last_attack_time = current_time
	
	if attack_count >= 3:
		emit_signal("special_attack")
		attack_count = 0

func _on_attack_interval_timeout():
	attack_count = 0

func die():
	queue_free()
	print("Jefe derrotado")
	
	extends Node2D

# Variables del jefe
var health = 100
var attack_interval = 30 # 30 segundos
var attack_count = 0
var last_attack_time = 0.0

signal special_attack()

func _ready():
	# Configurar el temporizador de ataque especial
	var timer = Timer.new()
	timer.set_wait_time(attack_interval)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "_on_attack_interval_timeout")
	add_child(timer)
	timer.start()

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()
	else:
		check_special_attack()

func check_special_attack():
	var current_time = OS.get_ticks_msec() / 1000.0 # Obtener el tiempo actual en segundos
	if (current_time - last_attack_time) <= attack_interval:
		attack_count += 1
	else:
		attack_count = 1
	
	last_attack_time = current_time
	
	if attack_count >= 3:
		emit_signal("special_attack")
		attack_count = 0

func _on_attack_interval_timeout():
	attack_count = 0

func die():
	queue_free()
	print("Jefe derrotado")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
