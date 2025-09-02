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
	position += transform.x * (fireball_speed * delta)


func _on_enemy_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		self.queue_free()
