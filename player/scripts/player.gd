extends CharacterBody2D

const cool_temp := 10
const max_temp := 37
const min_temp := -17
var current_temp : int = 10


@export var max_speed : float = 200.0
@export var current_speed : float = 0.0

@export var move_speed : float = 200.0
@export var acc : float = 30.0
@export var decel : float = 30.0

@export var jump_height : float = 100
@export var jump_time_to_peak : float = 0.5
@export var jump_time_to_descent : float = 0.35

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _ready() -> void:
	set_temp()
	$temp_bar.max_value = max_temp
	set_temp_bar()

func _physics_process(delta):
	velocity.y += get_grav() * delta
	set_temp()
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_damage_increase"):
		damage_increase()
	elif Input.is_action_just_pressed("debug_damage_decrease"):
		damage_decrease()

func get_grav() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity
	

func get_horizontal_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("move_left"):
		horizontal -= 1.0
	if Input.is_action_pressed("move_right"):
		horizontal += 1.0
	
	return horizontal

func set_temp():
	$temp_label.text = "temp : %s°C" % current_temp

func set_temp_bar():
	$temp_bar.value = current_temp

func damage_decrease():
	print("decreasing")
	current_temp -= 1
	print(current_temp)
	if current_temp <= min_temp:
		current_temp = cool_temp
	set_temp_bar()
	
func damage_increase():
	print("increasing")
	current_temp += 1
	print(current_temp)
	if current_temp >= max_temp:
		current_temp = cool_temp
	set_temp_bar()
