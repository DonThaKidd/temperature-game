extends CharacterBody2D

## Movement settings
@export var speed = 150.0 ## Maximum speed
@export var acc = 200 ## Acceleration rate
@export var deceleration = 200 ## Deceleration rate

@export var jump_height : float = 100.0
@export var jump_time_to_peak : float = 0.3
@export var jump_time_to_descent : float = 0.2

@onready var jump_vel : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_grav : float = ((2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_grav : float = ((2.0 * jump_height) / jump_time_to_peak * jump_time_to_descent) * -1.0


func _physics_process(delta: float) -> void:
	print(velocity)
	velocity.y == get_grav() * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	
	var input_dir : Vector2 = input_direction()
	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
		## play_animation()
	
	else:
		decelerate() ## Decelerate to stop
	player_movement()

func accelerate(direction):
	velocity = velocity.move_toward(speed * direction, acc)

func decelerate():
	velocity = velocity.move_toward(Vector2.ZERO, deceleration)

func player_movement():
	move_and_slide()
	
func input_direction() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("left", "right")
	input_dir = input_dir.normalized()
	return input_dir

func get_grav():
	return jump_grav if velocity.y < 0.0 else fall_grav

func jump():
	velocity.y = jump_vel
