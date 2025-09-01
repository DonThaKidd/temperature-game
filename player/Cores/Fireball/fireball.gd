class_name Fireball
extends Area2D

@export var fireball_speed : int = 1000

var dir : float
var spawnPos : Vector2
var spawnRot : float

func ready() -> void:
	global_position = spawnPos
	global_rotation = spawnRot

func _process(delta: float) -> void:
	position += transform.x * (fireball_speed * delta)
