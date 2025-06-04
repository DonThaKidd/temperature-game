class_name FiniteStateMachine
extends Node

var states : Dictionary = {}

var current_state : State

var target : Node

func _ready() -> void:
	target = get_parent()
	
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.target = target
			child.state_manager = self
	
	change_state("IdleState")
	print(states)

func change_state(new_state : String):
	if current_state and current_state.name == new_state:
		return
	
	if current_state:
		current_state._exit_state()
	
	current_state = states.get(new_state)
	if current_state:
		current_state._enter_state()

func _process(delta : float):
	if current_state:
		current_state._process(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state._physics_process(delta)
	
