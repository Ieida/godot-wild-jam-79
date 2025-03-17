class_name UISlotHolder extends Container


signal slot_selected(slot: UISlot)


var selected_slot: UISlot


func _on_slot_selected(slot: UISlot):
	if selected_slot:
		selected_slot.set_pressed_no_signal(false)
	selected_slot = slot
	slot_selected.emit(slot)


func _ready() -> void:
	for ci in get_child_count():
		var c = get_child(ci) as UISlot
		if c:
			c.selected.connect(_on_slot_selected)


func deselect_all():
	selected_slot.set_pressed_no_signal(false)
	selected_slot = null
