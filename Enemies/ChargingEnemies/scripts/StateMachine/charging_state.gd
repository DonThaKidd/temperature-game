class_name EnemyCharge
extends Estate

signal player_hit

func _enter_state() -> void:
	on_charge()

func _exit_state() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass


func _on_player_detection_body_exited(body: Node2D) -> void:
	target.is_enemy_chase = false
	state_manager.change_state("wander_state")

func on_charge():
	var direction = (target.Player.position - target.position).normalized()
	target.velocity += direction * target.charge_speed
	target.move_and_slide()
	target.charge_timer.start()



func _on_charge_timer_timeout() -> void:
	target.is_enemy_chase = false
	var direction = (target.Player.position - target.position).normalized()
	target.velocity = (direction * target.charge_speed) * 0
	target.charge_timer.stop()
	
	state_manager.change_state("cooldown_state")


func _on_hit_box_component_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player hit!")
		player_hit.emit()
		
