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
	if body is Plant:
		visible_plants.append(body)


func _on_vision_body_exited(body: Node2D):
	if body is Plant:
		visible_plants.erase(body)


func _ready() -> void:
	vision_area.body_entered.connect(_on_vision_body_entered)
	vision_area.body_exited.connect(_on_vision_body_exited)


func get_closest_plant() -> Plant:
	if visible_plants.size() == 0: return null
	
	var pos: Vector2 = global_position
	var cp: Plant = null
	var cd: float = INF
	for plant in visible_plants:
		if plant.hitbox.is_depleted: continue
		
		var d := pos.distance_to(plant.global_position)
		if d < cd:
			cp = plant
			cd = d
	return cp
