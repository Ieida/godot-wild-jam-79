class_name Enemy extends CharacterBody2D


@export var attack_cooldown: float = 2
@export var damage: float = 10
@export var gravity: float = 980
@export var speed: float = 64
@onready var hitbox: Hitbox = $Hitbox
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var vision_area: Area2D = $VisionArea
var visible_plants: Array[Plant]


func _on_vision_body_entered(body: Node2D):
	if body.is_in_group(&"plant_colliders"):
		var plant = body.get_parent() as Plant
		if plant: visible_plants.append(plant)


func _on_vision_body_exited(body: Node2D):
	if body.is_in_group(&"plant_colliders"):
		var plant = body.get_parent() as Plant
		if plant: visible_plants.erase(plant)


func _ready() -> void:
	vision_area.body_entered.connect(_on_vision_body_entered)
	vision_area.body_exited.connect(_on_vision_body_exited)


func get_closest_plant() -> Plant:
	if visible_plants.size() == 0: return null
	
	var pos: Vector2 = global_position
	var cp: Plant = null
	var cd: float = INF
	for plant in visible_plants:
		var d := pos.distance_to(plant.global_position)
		if d < cd:
			cp = plant
			cd = d
	return cp
