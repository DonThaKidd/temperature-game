class_name jump_state
extends State

func _physics_process(delta: float) -> void:
	target.velocity.y += target.get_grav() * delta
	if Input.is_action_just_pressed("right_core_key") != true:
		if target.is_on_floor() and target.get_horizontal_velocity() == 0.0:
			state_manager.change_state("IdleState")
		elif target.is_on_floor():
			state_manager.change_state("WalkState")
	elif Input.is_action_just_pressed("right_core_key"):
		state_manager.change_state("SlamState")

func _enter_state():
	target.jump()
	
func _exit_state():
	pass
