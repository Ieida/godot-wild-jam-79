class_name Spawner extends Area2D


@export var active: bool
@export var spawnee_scene: PackedScene
@export var interval: float
@onready var game: Game = get_node("/root/Game")
var time_elapsed: float


func _physics_process(delta: float) -> void:
	if active:
		time_elapsed += delta
		if time_elapsed >= interval:
			time_elapsed = 0
			try_spawn()


func _spawned(node: Node):
	add_child(node)


func spawn_scene(scn: PackedScene):
	var n = scn.instantiate()
	_spawned(n)


func try_spawn():
	if has_overlapping_areas() or has_overlapping_bodies(): return
	
	spawn_scene(spawnee_scene)
