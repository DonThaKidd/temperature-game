class_name Fireball
extends CharacterBody2D

@export var fireball_speed : int = 1000

var dir : float
var spawnPos : Vector2
var spawnRot : float

func ready() -> void:
	global_position = spawnPos
	global_rotation = spawnRot

func _physics_process(delta: float) -> void:
	velocity = Vector2(fireball_speed, 0).rotated(dir)
	move_and_slide()
