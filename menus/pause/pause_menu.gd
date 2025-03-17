class_name PauseMenu extends Menu


func _input(event: InputEvent) -> void:
	if event.is_action(&"pause"):
		if event.is_pressed() and not event.is_echo():
			toggle()


func _ready() -> void:
	close()


func close():
	super()
	get_tree().paused = false


func open():
	super()
	get_tree().paused = true
