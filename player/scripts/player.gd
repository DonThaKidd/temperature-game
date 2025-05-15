class_name player

extends CharacterBody2D

var state_manager : Node

## Movement settings
@export var speed = 150.0 ## Maximum speed
@export var acc = 170 ## Acceleration rate
@export var deceleration = 200 ## Deceleration rate

## jump time graph
@export var jump_vel : float = -1500

var jump_grav = 10000
var fall_grav = 10500

func _physics_process(delta: float) -> void:
	velocity.y += get_grav() * delta
	move_and_slide()

func _ready():
	state_manager = $FiniteStateMachine


func get_grav() -> float:
	if velocity.y < 0.0:
		return jump_grav 
	return fall_grav

## jumping function
func jump() -> void:
	velocity.y = jump_vel

func input_direction() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("left", "right")
	input_dir = input_dir.normalized()
	return input_dir
