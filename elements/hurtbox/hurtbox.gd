class_name Hurtbox extends Area2D


@export var active: bool
@export var avoid_enemies: bool
@export var avoid_plants: bool
@export var damage: float
var flipped: bool


func _physics_process(delta: float) -> void:
	if active:
		if flipped:
			position.x = -absf(position.x)
			var c = get_child(0) as Node2D
			c.position.x = -absf(c.position.x)
		else:
			position.x = absf(position.x)
			var c = get_child(0) as Node2D
			c.position.x = absf(c.position.x)
		
		for a in get_overlapping_areas():
			if a is Hitbox:
				var p = a.get_parent()
				if p is Enemy and avoid_enemies: continue
				if p is Plant and avoid_plants: continue
				a.take_hit(damage * delta)
