class_name State extends Node


const NULL_STATE := &"null"


@export var reactivate: bool
var active: bool
var machine: StateMachine


func enter():
	pass


func exit():
	pass


func set_active(actv: bool):
	var was_active := active
	active = actv
	if active: enter()
	elif was_active: exit()
