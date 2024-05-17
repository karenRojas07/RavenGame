extends CharacterBody2D

class_name Player

const moveSpeed = 70
const maxSpeed = 100
const jumpHeight = -300
const gravity = 15

@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer

@export var attacking = false

func _ready():
	GameManager.player = self

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

	else:
		animationPlayer.play("IDLE")
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

func die():
	GameManager.respawn_player()
