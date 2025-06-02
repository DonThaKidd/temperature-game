
extends CharacterBody2D

@export var move_speed : float = 200.0
@export var air_jumps_total : int = 1

@export var jump_height : float = 100
@export var jump_time_to_peak : float = 0.5
@export var jump_time_to_descent : float = 0.35

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _physics_process(delta):
	velocity.y += get_grav() * delta
	velocity.x = get_horizontal_velocity() * move_speed
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()

func get_grav() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity
	
func air_jump():
	velocity.y = jump_velocity

func get_horizontal_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("move_left"):
		horizontal -= 1.0
	if Input.is_action_pressed("move_right"):
		horizontal += 1.0
	
	return horizontal
