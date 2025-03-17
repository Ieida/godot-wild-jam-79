class_name UISlot extends Button


signal selected(slot: UISlot)


@export var item: UISlotItem


func _on_toggled(on: bool):
	if on: selected.emit(self)


func _ready() -> void:
	toggled.connect(_on_toggled)
