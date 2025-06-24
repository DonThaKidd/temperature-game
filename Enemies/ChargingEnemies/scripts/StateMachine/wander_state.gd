class_name EnemyWander
extends Estate

func _enter_state() -> void:
	pass

func _exit_state() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	move(delta)
	target.move_and_slide()
	
func move(delta):
	if !target.dead:
		if !target.is_enemy_chase:
			target.velocity += target.dir * target.speed * delta
		target.is_roaming = true
	elif target.dead:
		target.velocity.x = 0

func choose(array):
	array.shuffle()
	return array.front()


func _on_direction_timer_timeout() -> void:
	target.direction_timer.wait_time = choose([1.5,2.0,2.5])
	if !target.is_enemy_chase:
		target.dir = choose([Vector2.LEFT, Vector2.RIGHT])
		target.velocity.x = 0

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
			print("enemy_found")
			state_manager.change_state("charging_state")
			target.is_enemy_chase = true
