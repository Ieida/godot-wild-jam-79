class_name EnemySpawner extends Spawner


func _spawned(node: Node):
	game.current_level.add_child(node)
	if node is Enemy:
		node.global_position = global_position
