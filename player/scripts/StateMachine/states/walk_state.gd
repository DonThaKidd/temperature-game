class_name walk_state
extends State

func _enter_state():
	print("entered walking state")

func _exit_state():
	print("exited walking state")

func _process(delta: float) -> void:
	if Input.is_action_pressed("jump") and target.is_on_floor():
		state_manager.change_state("JumpState")

func _physics_process(delta: float) -> void:
	if target.get_input_direction() != Vector2.ZERO:
			target.velocity = target.velocity.move_toward(target.get_input_direction() * target.speed, target.acceleration * delta)
			target.move_and_slide()
	
	else:
		## Decelerate to stop
		target.velocity = target.velocity.move_toward(Vector2.ZERO, target.deceleration * delta)
		state_manager.change_state("IdleState")
