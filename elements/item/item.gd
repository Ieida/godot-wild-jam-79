class_name Item extends CharacterBody2D


signal dropped
signal picked_up


@export var can_be_picked_up: bool = true
@export var gravity: float = 980
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var pick_label: Label = $PickUp
var picked: bool


func _physics_process(delta: float) -> void:
	if not picked and not is_on_floor():
		velocity.x = 0.
		velocity.y += gravity * delta
		
		move_and_slide()


func _ready() -> void:
	pick_label.hide()


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
