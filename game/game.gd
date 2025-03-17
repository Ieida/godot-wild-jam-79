class_name Game extends Node


@onready var levels: Node = $Levels
var current_level: Level


func _ready() -> void:
	print("changing level to non-existent path")
	change_level_to_path("none.tscn")


func change_level_to_node(node: Level):
	if current_level: unload_current_level()
	levels.add_child(node)


func change_level_to_path(spath: String):
	if ResourceLoader.exists(spath, "PackedScene"):
		var s = load(spath) as PackedScene
		if s: change_level_to_scene(s)


func change_level_to_scene(pscene: PackedScene):
	var n = pscene.instantiate() as Level
	if n: change_level_to_node(n)


func unload_current_level():
	current_level.reparent(null)
	current_level.queue_free()
	current_level = null
