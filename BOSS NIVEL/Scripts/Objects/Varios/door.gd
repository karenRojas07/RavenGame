extends Node2D

var llave_recogida: bool = false

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		if area.get_parent().llave_recogida:
			$AnimationPlayer.play("open")
			area.get_parent().delete_key()

