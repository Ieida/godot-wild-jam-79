class_name GameOver extends Menu


@onready var game: Game = get_node(^"/root/Game")


func _on_retry_pressed():
	game.restart_level()
	close()


func _ready() -> void:
	close()
	%Retry.pressed.connect(_on_retry_pressed)
