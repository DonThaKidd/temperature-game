class_name Fireball
extends Area2D

signal enemy_hit

@export var fireball_speed : int = 1000

var dir : float
var spawnPos : Vector2
var spawnRot : float

func ready() -> void:
	global_position = spawnPos
	global_rotation = spawnRot

func _process(delta: float) -> void:
	position += transform.x * (fireball_speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_hit.emit()
		self.queue_free()

func _on_enemy_hit() -> void:
	print("signal sent!")
