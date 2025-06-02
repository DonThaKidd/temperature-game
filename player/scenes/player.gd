extends CharacterBody2D

@export var move_speed : float = 200.0
@export var decel : float = 150.0
@export var acc : float = 175.0

@export var jump_height : float = 30
@export var jump_time_to_peak : float = 0.5
@export var jump_time_to_descent : float = 0.25

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _physics_process(delta):
	velocity.y += get_grav() * delta

func get_grav() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y += jump_velocity
	
func input_direction():
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("left", "right")
	input_dir = input_dir.normalized()
	return input_dir
