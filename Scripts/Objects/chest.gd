extends Node2D
class_name Chest

@export var key_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func open():
	$AnimationPlayer.play("open")
	$AnimationPlayer.animation_finished.connect(self._on_animation_finished)
	
func _on_animation_finished(anim_name: String):
	if anim_name == "open":
		var key_instance = key_scene.instantiate()
		key_instance.position = position
		get_parent().add_child(key_instance)
		$AnimationPlayer.animation_finished.disconnect(self._on_animation_finished)
