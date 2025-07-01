class_name slam_state
extends State

func _enter_state() -> void:
	print("entered slam state")
	target.slam()

func _exit_state() -> void:
	print("exited slam state")

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if target.is_on_floor():
		state_manager.change_state("IdleState")
		target.slam_hitbox.monitoring = true


func _on_slam_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		print("enemy found")
