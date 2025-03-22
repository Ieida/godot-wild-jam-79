class_name Item extends CharacterBody2D


signal dropped
signal picked_up


@export var can_be_picked_up: bool = true
@export var gravity: float = 980
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var pick_label: Label = $PickUp
var picked: bool


func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action(&"pick_up"):
		if event.is_pressed() and not event.is_echo():
			pick_up()


func _on_mouse_entered():
	pick_label.show()


func _on_mouse_exited():
	pick_label.hide()


func _physics_process(delta: float) -> void:
	if picked:
		var mp = get_global_mouse_position()
		global_position = mp
	else:
		if not is_on_floor():
			velocity.x = 0.
			velocity.y += gravity * delta
		
		move_and_slide()


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pick_label.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action(&"pick_up"):
		if picked and event.is_released() and not event.is_echo():
			drop()


func drop():
	if not picked: return
	
	picked = false
	collision_shape.disabled = false
	dropped.emit()


func pick_up():
	if picked: return
	
	picked = true
	collision_shape.disabled = true
	picked_up.emit()
