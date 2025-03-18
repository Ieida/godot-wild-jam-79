class_name UISlotHolder extends Container


signal slot_selected(slot: UISlot)


var button_group: ButtonGroup
var selected_slot: UISlot


func _on_button_group_pressed(button: BaseButton):
	if not button is UISlot: return
	
	_on_slot_selected(button)


func _on_slot_selected(slot: UISlot):
	if selected_slot:
		selected_slot.button_pressed = false
	selected_slot = slot
	slot_selected.emit(slot)


func _ready() -> void:
	button_group = ButtonGroup.new()
	button_group.pressed.connect(_on_button_group_pressed)
	for ci in get_child_count():
		var c = get_child(ci) as UISlot
		if c:
			c.button_group = button_group


func deselect_all():
	selected_slot.set_pressed_no_signal(false)
	selected_slot = null
