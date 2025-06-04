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
	var dir = Vector2(direction, 0)
	target.velocity = target.velocity.move_toward(target.move_speed * dir, target.acc)

func decelerate():
	target.velocity = target.velocity.move_toward(Vector2.ZERO, target.decel)

func player_movement():
	target.move_and_slide()
