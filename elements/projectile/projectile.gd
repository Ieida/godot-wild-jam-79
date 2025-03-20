class_name Projectile extends ShapeCast2D


@export var avoid_enemies: bool
@export var avoid_plants: bool
@export var damage: float
@export var speed: float
@onready var sprite: AnimatedSprite2D = $Sprite


func _handle_collision():
	var ht: bool
	for ci in get_collision_count():
		var c = get_collider(ci)
		if c is Hitbox:
			var prnt = c.get_parent()
			if avoid_enemies and prnt is Enemy: continue
			if avoid_plants and prnt is Plant: continue
			_on_collision(c)
			ht = true
	
	if ht:
		global_position = global_position + target_position * get_closest_collision_unsafe_fraction()


func _on_collision(hitbox: Hitbox):
	hitbox.take_hit(damage)
	if not is_queued_for_deletion(): queue_free()


func _physics_process(delta: float) -> void:
	var forward = global_transform.basis_xform(Vector2.RIGHT)
	var movement_delta: Vector2 = forward * speed * delta
	global_position += movement_delta - (forward * 0.01)
	target_position = movement_delta
	force_shapecast_update()
	if is_colliding(): _handle_collision()
