class_name Plant extends CharacterBody2D


## Should the plant spawn as planted
@export var planted: bool
## How much time for the plant to age 1 year
@export var age_speed: float = 1
## Amount of time between each attack
@export var attack_cooldown: float = 1
@export var damage: float = 20
@export var max_age: float
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var hitbox: Hitbox = $Hitbox
@onready var initial_z_index: int = z_index
@onready var ray_cast: RayCast2D = $RayCast2D
@onready var shape_cast: ShapeCast2D = $ShapeCast
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite_material: ShaderMaterial = sprite.material
@onready var state_machine: StateMachine = $StateMachine
@onready var vision_area: Area2D = $VisionArea
var age: float
var visible_enemies: Array[Enemy]


func _on_hitbox_healed(_amount: float):
	if sprite_material:
		sprite_material.set_shader_parameter(&"saturation", hitbox.get_health_normalized())
		state_machine.activate_state(&"idle")


func _on_vision_body_entered(body: Node2D):
	if body is Enemy:
		visible_enemies.append(body)


func _on_vision_body_exited(body: Node2D):
	if body is Enemy and visible_enemies.has(body):
		visible_enemies.erase(body)


func _physics_process(delta: float) -> void:
	if planted: age += (1.0 / age_speed) * delta


func _ready() -> void:
	collision_shape.disabled = true
	hitbox.healed.connect(_on_hitbox_healed)
	vision_area.body_entered.connect(_on_vision_body_entered)
	vision_area.body_exited.connect(_on_vision_body_exited)
	if planted:
		collision_shape.disabled = false
	else:
		z_index = 1


func can_be_planted() -> bool:
	ray_cast.target_position = Vector2(0, 128.)
	ray_cast.force_raycast_update()
	if not ray_cast.is_colliding(): return false
	
	shape_cast.target_position = Vector2(0, 128.0)
	shape_cast.force_shapecast_update()
	if shape_cast.is_colliding():
		for coll_index in shape_cast.get_collision_count():
			var coll = shape_cast.get_collider(coll_index)
			if coll and coll is Plant:
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
	ray_cast.target_position = Vector2(0, 128.)
	ray_cast.force_raycast_update()
	
	var pos = global_position
	if ray_cast.is_colliding():
		pos.y = ray_cast.get_collision_point().y
		var shp = collision_shape.shape
		if shp and shp is RectangleShape2D:
			pos.y -= shp.size.y / 2.0
	global_position = pos
	collision_shape.disabled = false
	z_index = initial_z_index
	planted = true
