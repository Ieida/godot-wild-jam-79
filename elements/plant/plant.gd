class_name Plant extends ShapeCast2D


@onready var collider: StaticBody2D = $Collider


func _ready() -> void:
	collider.process_mode = Node.PROCESS_MODE_DISABLED


func can_be_planted() -> bool:
	target_position = Vector2(0, 1000.0)
	force_shapecast_update()
	if is_colliding():
		for coll_index in get_collision_count():
			var coll = get_collider(coll_index) as StaticBody2D
			if coll and coll.is_in_group(&"plant_colliders"):
				return false
		return true
	return false


func plant():
	if not is_colliding(): return
	
	var pos = target_position * get_closest_collision_safe_fraction()
	global_position = to_global(pos)
	collider.process_mode = Node.PROCESS_MODE_INHERIT
