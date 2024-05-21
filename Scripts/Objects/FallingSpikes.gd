extends Node2D

@export var speed = 160.00
@export var reset_time = 3.00

var current_speed = 0.0
var is_falling = false

@onready var spawn_pos = global_position

func _physics_process(delta):
	position.y += current_speed * delta

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		var damage = randf()
		if damage < 0.8:
			damage = 1
		else:
			damage = 2
		area.get_parent().take_damage(damage)
		queue_free()


func _on_player_detect_area_entered(area):
	if area.get_parent() is Player and not is_falling:
		$AnimationPlayer.play("shake")
		fall()
		is_falling = false

func fall():
	is_falling = true
	current_speed = speed
	await get_tree().create_timer(reset_time).timeout
	reset_spike()
	
func reset_spike():
	position = spawn_pos
	current_speed = 0.0
	is_falling = false
	$AnimationPlayer.stop(false)
	
