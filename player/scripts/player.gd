extends CharacterBody2D

const cool_temp := 10
const max_temp := 37
const min_temp := -17
var current_temp : int = 10

@export var fireball : PackedScene
var fireball_damage : int = 9

@export var max_speed : float = 200.0
@export var current_speed : float = 0.0

@export var move_speed : float = 200.0
@export var acc : float = 30.0
@export var decel : float = 30.0

@export var jump_height : float = 100
@export var jump_time_to_peak : float = 0.5
@export var jump_time_to_descent : float = 0.35
@export var jump_time_to_slam : float = 0.01

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
@onready var slam_gravity : float = ((-2.0 * jump_height) / (jump_time_to_slam * jump_time_to_slam)) * -1.0

func _ready() -> void:
	set_temp()
	$Camera2D/temp_bar.max_value = max_temp
	set_temp_bar()

func _physics_process(delta):
	set_temp()
	move_and_slide()
	if Input.is_action_just_pressed("right_core_key"):
		fireball_core()
		damage_increase(fireball_damage)

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
	$Camera2D/temp_label.text = "temp : %s°C" % current_temp

func set_temp_bar():
	$Camera2D/temp_bar.value = current_temp

func damage_decrease(dmg):
	current_temp -= dmg
	if current_temp <= min_temp:
		hide()
	set_temp_bar()
	
func damage_increase(dmg):
	current_temp += dmg
	if current_temp >= max_temp:
		hide()
	set_temp_bar()

func fireball_core():
	var newFireball = fireball.instantiate() as Node2D
	get_tree().current_scene.add_child(newFireball)
	newFireball.global_position = global_position
	
	if velocity.x > 0:
		newFireball.rotation = 0
	elif velocity.x < 0:
		newFireball.rotation = 180
