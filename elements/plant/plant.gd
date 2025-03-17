class_name Plant extends ShapeCast2D


@onready var collider: StaticBody2D = $Collider
var age: float


func _physics_process(delta: float) -> void:
	age += delta


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
	
	var pos = get_collision_point(0)
	pos.x = global_position.x
	pos.y -= 10.0
	global_position = pos
	collider.process_mode = Node.PROCESS_MODE_INHERIT
