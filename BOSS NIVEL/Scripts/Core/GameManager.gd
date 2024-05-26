extends Node

signal total_hearts(int)

var hearts : int

var current_checkpoint : Checkpoint

var player : Player

func respawn_player():
	player.health = player.max_health
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func hearts_counter():
	print("HOLA")
	hearts += player.health
	emit_signal("total_hearts", player.health)
