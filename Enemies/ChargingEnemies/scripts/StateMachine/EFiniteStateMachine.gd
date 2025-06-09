class_name EFiniteStateMachine
extends Node

@export var state : Estate

func _ready() -> void:
	change_state(state)
	

func change_state(new_state : Estate):
	if state is Estate:
		state._exit_state
	new_state._enter_state()
	state = new_state
