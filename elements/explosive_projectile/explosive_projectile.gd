class_name ExplosiveProjectile extends Projectile


@export var explosion_scene: PackedScene


func _on_collision(_hitbox: Hitbox):
	set_physics_process(false)
	sprite.hide()
	_spawn_explosion()


func _spawn_explosion():
	var expl = explosion_scene.instantiate() as Explosion
	if expl:
		expl.damage = damage
		expl.damage_enemies = not avoid_enemies
		expl.damage_plants = not avoid_plants
		add_child(expl)
		expl.global_position = global_position
		expl.global_rotation = global_rotation
