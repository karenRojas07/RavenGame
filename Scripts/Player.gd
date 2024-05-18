extends CharacterBody2D

class_name Player

const moveSpeed = 70
const maxSpeed = 100
const jumpHeight = -300
const gravity = 15
const initial_lives = 2

@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer

@export var attacking = false

var max_health = 2
var health = 0
var can_take_damage = true
var receiving_damage = false

signal health_changed(current_health, max_health)

func _ready():
	health = max_health
	GameManager.player = self
	emit_signal("health_changed", health, max_health)
	$AnimationPlayer.play("die")

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()
		

func _physics_process(_delta):
	velocity.y += gravity
	var friction = false

	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = false
		animationPlayer.play("WALK")
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)

	elif Input.is_action_pressed("ui_left"):
		sprite.flip_h = true
		animationPlayer.play("WALK")
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)
	
	elif !receiving_damage:
		animationPlayer.play("IDLE")
		friction = true
	else: 
		friction = true

	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = jumpHeight
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.5)
	else:
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.01)

	move_and_slide()
	
	if position.y >= 160:
		die()

func attack():
	var overlapping_objects = $AttackArea.get_overlapping_areas()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().die()
		if area.get_parent() is Chest:
			area.get_parent().open()
	
	attacking = true
	$AnimationHacha.play("Attack")

func take_damage(damage_amount : int):
	
	if can_take_damage:
		receiving_damage = true
		$AnimationPlayer.play("die")
		health -= damage_amount
		emit_signal("health_changed", health, max_health)
		
		if health <= 0:
			die()
		
		
			
			
func add_health(extra_health: int):
	max_health += extra_health
	health += extra_health
	emit_signal("health_changed", health, max_health)

func iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true

func die():
	GameManager.respawn_player()
	max_health = initial_lives
	health = max_health
	emit_signal("health_changed", health, max_health)
