class_name Hitbox extends Area2D


signal depleted
signal filled
signal healed(amount: float)
signal hit


@export var initial_health: float
@export var max_health: float
@onready var health: float = initial_health
var full: bool
var is_depleted: bool


func _ready() -> void:
	full = is_equal_approx(health, max_health)
	is_depleted = is_zero_approx(health)


func get_health_normalized() -> float:
	return health / max_health


func heal(amount: float):
	if is_equal_approx(health, max_health): return
	
	health = minf(max_health, health + amount)
	
	if is_depleted and not is_zero_approx(health): is_depleted = false
	
	if is_equal_approx(health, max_health):
		full = true
		filled.emit()
	else: healed.emit(amount)


func take_hit(damage: float):
	if is_depleted: return
	
	health = maxf(0, health - damage)
	
	if is_zero_approx(health):
		is_depleted = true
		depleted.emit()
	else: hit.emit()
