class_name player

extends CharacterBody2D

var state_manager : Node

## Movement settings
@export var speed = 150.0            # Maximum speed
@export var acceleration = 120    # Acceleration rate
@export var deceleration = 170     # Deceleration rate

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

## jump time graph
@export var jump_height : float = 175
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_descent : float = 0.2

## math found on GDC.
var jump_vel : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
var jump_grav : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
var fall_grav : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0

func _physics_process(delta: float) -> void:
	velocity.y += get_grav() * delta
	
	move_and_slide()


func _ready():
	state_manager = $FiniteStateMachine


func get_grav() -> float:
	return jump_grav if velocity.y < 0.0 else fall_grav

## jumping function
func jump() -> void:
	velocity.y = jump_vel

func get_input_direction():
	 
	var input_direction = Vector2.ZERO
	
	## Get input direction
	if Input.is_action_pressed("right"):
		input_direction.x += 1
	if Input.is_action_pressed("left"):
		input_direction.x -= 1
	
	input_direction = round(input_direction)
	return input_direction
