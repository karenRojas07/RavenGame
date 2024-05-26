extends Node2D

class_name Checkpoint

@export var spawnpoint = false
@onready var animationPlayer = $AnimationPlayer

var activated = false

func activate():
	GameManager.current_checkpoint = self
	animationPlayer.play("Cartel")
	activated = true
	


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		activate()
