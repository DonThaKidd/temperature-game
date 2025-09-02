extends CharacterBody2D

signal player_hit

const speed = 10
const charge_speed = 300
@export var enemy_type : bool

var health = 18
var health_max = 18
var health_min = 0

var knockback : Vector2 = Vector2.ZERO
var knockback_timer : float = 0.0

var dead : bool = false
var taking_damage : bool = false
var damage_to_deal = 15
var is_dealing_damage : bool = false

var dir : Vector2
const gravity = 400
var knockback_force = 200
var is_roaming : bool = true
var is_enemy_chase : bool = false

@onready var direction_timer : Timer = $TimerHandler/DirectionTimer
@onready var charge_timer : Timer = $TimerHandler/ChargeTimer
@onready var cooldown_timer: Timer = $TimerHandler/CooldownTimer

@onready var player_detection: Area2D = $PlayerDetection

var player_position
var target_position
@onready var Player: CharacterBody2D = $"../Player"


func _ready() -> void:
	set_temp()

func _process(delta: float) -> void:
	
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0

func _physics_process(delta: float) -> void:
	if knockback_timer > 0.0:
		velocity = knockback
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			knockback = Vector2.ZERO
	
	move_and_slide()

func _on_charging_state_player_hit() -> void:
	player_hit.emit()
	Player.damage_increase(damage_to_deal)


func _on_hurtbox_component_body_entered(body: Node2D) -> void:
	if body.is_in_group("fireball"): 
		if health <= health_max:
			health = health - Player.fireball_damage
			set_temp()
			var knockback_direction = (body.global_position - global_position).normalized()
			apply_knockback(knockback_direction, -100.0, 0.12)
	if health <= health_min:
		self.queue_free()

func set_temp():
	$Label.text = "temp : %s°C" % health

func apply_knockback(direction: Vector2, force : float, knockback_duration : float):
	knockback = direction * force
	knockback_timer = knockback_duration
