class_name Explosion extends Area2D


@export var damage: float
@export var damage_enemies: bool
@export var damage_plants: bool
@onready var sprite: AnimatedSprite2D = $Sprite


func _on_anim_finish():
	if sprite.animation == &"explosion":
		queue_free()


func _on_area_entered(area: Area2D):
	if not area is Hitbox: return
	var p = area.get_parent()
	if not damage_enemies and p is Enemy: return
	if not damage_plants and p is Plant: return
	area.take_hit(damage)


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	sprite.animation_finished.connect(_on_anim_finish)
