class_name Hitbox extends Area2D


signal depleted
signal hit


@export var max_health: float
@onready var health: float = max_health
var is_depleted: bool


func get_health_normalized() -> float:
	return health / max_health


func take_hit(damage: float):
	if is_depleted: return
	
	health = maxf(0, health - damage)
	if is_zero_approx(health):
		is_depleted = true
		depleted.emit()
	else: hit.emit()
