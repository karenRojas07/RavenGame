extends CharacterBody2D

const moveSpeed = 70
const maxSpeed = 100
const jumpHeight = -300
const gravity = 15

@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer

func _physics_process(_delta):
	velocity.y += gravity
	var friction = false

	# Establecer la velocidad hacia la izquierda
	velocity.x = max(velocity.x - moveSpeed, -maxSpeed)
	sprite.flip_h = true  # Voltear el sprite hacia la izquierda
	animationPlayer.play("WALK")

	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = jumpHeight
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.5)
	else:
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.01)

	move_and_slide()
