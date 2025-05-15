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
	var input_dir: Vector2 = target.input_direction()
	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
		## play_animation()
	
	else:
		decelerate() ## Decelerate to stop
		state_manager.change_state("IdleState")
	player_movement()

func accelerate(direction):
	target.velocity = target.velocity.move_toward(target.speed * direction, target.acc)

func decelerate():
	target.velocity = target.velocity.move_toward(Vector2.ZERO, target.deceleration)

func player_movement():
	target.move_and_slide()
