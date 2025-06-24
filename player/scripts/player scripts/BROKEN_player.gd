class_name player

extends CharacterBody2D

var state_manager : Node

## Movement settings
@export var speed = 150.0 ## Maximum speed
@export var acc = 200 ## Acceleration rate
@export var deceleration = 200 ## Deceleration rate

@export var jump_height : float = -2000.0
@onready var jump_grav : float = 1075
@onready var fall_grav : float = 1050

const grav = 120

func get_grav():
	if velocity.y == 0.0: 
		return jump_grav 
	return fall_grav

func _physics_process(delta: float) -> void:
	velocity.y += get_grav() * delta
	
	move_and_slide()

func _ready():
	state_manager = $FiniteStateMachine


func input_direction() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("left", "right")
	input_dir = input_dir.normalized()
	return input_dir

func jump():
	velocity.y = jump_height
