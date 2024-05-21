extends Node2D

var key_collected:bool = false

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().collect_key()
		queue_free()
