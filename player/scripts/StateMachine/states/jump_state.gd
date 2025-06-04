class_name jump_state
extends State

func _physics_process(delta: float) -> void:
	target.velocity.y += target.get_grav() * delta
	if target.is_on_floor() and target.get_horizontal_velocity() == 0.0:
		state_manager.change_state("IdleState")
	elif target.is_on_floor():
		state_manager.change_state("WalkState")

func _enter_state():
	target.jump()
	print("entered jump state")
	
func _exit_state():
	print("exited jump state")
