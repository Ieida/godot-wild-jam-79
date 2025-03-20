class_name Plant extends ShapeCast2D


## Should the plant spawn as planted
@export var planted: bool
## How much time for the plant to age 1 year
@export var age_speed: float = 1
## Amount of time between each attack
@export var attack_cooldown: float = 1
@export var damage: float = 20
@export var max_age: float
@onready var collider: CollisionObject2D = $Collider
@onready var hitbox: Hitbox = $Hitbox
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var vision_area: Area2D = $VisionArea
var age: float
var visible_enemies: Array[Enemy]


func _on_vision_body_entered(body: Node2D):
	if body is Enemy:
		visible_enemies.append(body)


func _on_vision_body_exited(body: Node2D):
	if body is Enemy and visible_enemies.has(body):
		visible_enemies.erase(body)


func _physics_process(delta: float) -> void:
	if planted: age += (1.0 / age_speed) * delta


func _ready() -> void:
	collider.process_mode = Node.PROCESS_MODE_DISABLED
	vision_area.body_entered.connect(_on_vision_body_entered)
	vision_area.body_exited.connect(_on_vision_body_exited)
	if planted:
		collider.process_mode = Node.PROCESS_MODE_INHERIT


func can_be_planted() -> bool:
	target_position = Vector2(0, 1000.0)
	force_shapecast_update()
	if is_colliding():
		for coll_index in get_collision_count():
			var coll = get_collider(coll_index) as CollisionObject2D
			if coll and coll.is_in_group(&"plant_colliders"):
				return false
		return true
	return false


func get_closest_enemy() -> Enemy:
	if visible_enemies.size() == 0: return null
	
	var pos: Vector2 = global_position
	var ce: Enemy = null
	var cd: float = INF
	for e in visible_enemies:
		var d := pos.distance_to(e.global_position)
		if d < cd:
			ce = e
			cd = d
	return ce


func plant():
	if not is_colliding(): return
	
	var pos = get_collision_point(0)
	pos.x = global_position.x
	if shape is RectangleShape2D:
		pos.y -= shape.size.y / 2.0
	global_position = pos
	collider.process_mode = Node.PROCESS_MODE_INHERIT
	planted = true
