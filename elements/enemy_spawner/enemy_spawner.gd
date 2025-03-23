class_name EnemySpawner extends Spawner


@export var enemy_scenes: Array[PackedScene]


func _spawned(node: Node):
	game.current_level.add_child(node)
	if node is Enemy:
		node.global_position = global_position


func try_spawn():
	if has_overlapping_areas() or has_overlapping_bodies(): return
	
	spawn_scene(enemy_scenes.pick_random())
