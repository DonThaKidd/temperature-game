class_name EnemyCooldown
extends Estate

func _enter_state() -> void:
	target.cooldown_timer.start()

func _exit_state() -> void:
	pass

func _process(delta: float):
	pass

func _physics_process(delta: float) -> void:
	pass



func _on_cooldown_timer_timeout() -> void:
	state_manager.change_state("wander_state")
