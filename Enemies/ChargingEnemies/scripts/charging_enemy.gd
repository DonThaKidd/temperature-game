extends CharacterBody2D

signal player_hit



const speed = 10
const charge_speed = 300

var  health = 3
var health_max = 3
var health_min = 0

var dead : bool = false
var taking_damage : bool = false
var damage_to_deal = 5
var is_dealing_damage : bool = false

var dir : Vector2
const gravity = 400
var knockback_force = 200
var is_roaming : bool = true
var is_enemy_chase : bool = false

@onready var direction_timer : Timer = $TimerHandler/DirectionTimer
@onready var charge_timer : Timer = $TimerHandler/ChargeTimer
@onready var cooldown_timer: Timer = $TimerHandler/CooldownTimer
@onready var sprite: FlippableSprite = $FlippableSprite

@onready var player_detection: Area2D = $PlayerDetection

var player_position
var target_position
@onready var Player: CharacterBody2D = $"../Player"


func _process(delta: float) -> void:
	update_flip()
	
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0

func update_flip():
	if dir.x > 0:
		sprite.flipped = false
	elif dir.x < 0:
		sprite.flipped = true


func _on_hit_box_component_body_entered(body: Node2D) -> void:
	print("player!")
	player_hit.emit()
