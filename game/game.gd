class_name Game extends Node


signal level_changed
signal level_restarted


@onready var levels: Node = $Levels
@onready var menus_parent: CanvasLayer = $Menus
var current_level: Level
var menus: Dictionary[StringName, Menu]


func _ready() -> void:
	if levels.get_child_count():
		for ci in levels.get_child_count():
			var l = levels.get_child(ci)
			if l:
				current_level = l
				break
	if menus_parent.get_child_count():
		for ci in menus_parent.get_child_count():
			var m = menus_parent.get_child(ci)
			if m:
				var n = m.name.to_snake_case()
				menus[n] = m


func change_level_to_node(node: Level):
	if current_level: unload_current_level()
	levels.add_child(node)
	current_level = node
	level_changed.emit()


func change_level_to_path(spath: String):
	if ResourceLoader.exists(spath, "PackedScene"):
		var s = load(spath) as PackedScene
		if s: change_level_to_scene(s)


func change_level_to_scene(pscene: PackedScene):
	var n = pscene.instantiate() as Level
	if n: change_level_to_node(n)


func restart_level():
	if current_level.scene_file_path:
		change_level_to_path(current_level.scene_file_path)
		level_restarted.emit()


func unload_current_level():
	levels.remove_child(current_level)
	current_level.queue_free()
	current_level = null
