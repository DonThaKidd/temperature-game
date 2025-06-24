class_name idle_state
extends State


func _process(delta: float) -> void:
	
	if Input.is_action_pressed("jump") and target.is_on_floor():
		state_manager.change_state("JumpState")
	
	if target.get_horizontal_velocity() != 0.0:
		state_manager.change_state("WalkState")

func _enter_state():
	pass ## any animations or such go here 

func _exit_state():
	pass
