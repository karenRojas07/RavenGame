extends Node2D

var llave_recogida: bool = false

func _ready():
	pass

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		if area.get_parent().llave_recogida:
			$AnimationPlayer.play("open")
			area.get_parent().delete_key()
			await get_tree().create_timer(2.0).timeout
			get_tree().change_scene_to_file("res://Scenes/Map3.tscn")
			area.get_parent().delete_key()
			


