extends CanvasLayer

@onready var heart_counter = $HeartCounter

func _ready():
	if GameManager.player:
		GameManager.player.connect("health_changed", Callable(self, "update_heart_display"))
	update_heart_display(GameManager.player.health, GameManager.player.max_health)

func update_heart_display(current_health, max_health):
	heart_counter.text = str(current_health) + " / " + str(max_health)
