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
	target.velocity.x = target.get_horizontal_velocity() * target.move_speed
	
	var direction = Input.get_axis("left", "right")
	if direction:
		accelerate(direction)
	else:
		decelerate()
	
	player_movement()

func accelerate(direction):
	target.current_speed += target.acc
	target.current_speed = clamp(target.current_speed, -target.max_speed, target.max_speed)
	target.velocity.x = direction * target.current_speed

func decelerate():
	target.velocity.x = move_toward(target.velocity.x, 0, target.decel)

func player_movement():
	target.move_and_slide()
