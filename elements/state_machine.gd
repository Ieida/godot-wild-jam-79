class_name StateMachine extends State


@onready var states: Dictionary[StringName, State]
var active_state: StringName = NULL_STATE


func _ready() -> void:
	for ci in get_child_count():
		var c = get_child(ci)
		if c is State:
			states[c.name] = c
			c.machine = self


func activate_state(state_name: StringName):
	if not states.has(state_name): return
	
	var state := states[state_name]
	if active_state != NULL_STATE:
		var actv_state := states[active_state]
		if state_name == active_state:
			if actv_state.reactivate:
				actv_state.set_active(true)
		else:
			actv_state.set_active(false)
			active_state = state_name
			state.set_active(true)
	else:
		active_state = state_name
		state.set_active(true)


func deactivate_state():
	if active_state == NULL_STATE: return
	
	var state := states[active_state]
	state.set_active(false)
	active_state = NULL_STATE
