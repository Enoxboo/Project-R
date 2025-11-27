extends State

func physics_update(_delta: float) -> void:
	var target_position: Vector2 = parent.player.global_position
	var self_position: Vector2 = parent.global_position
	parent.velocity = (target_position - self_position).normalized() * parent.data.speed
	parent.move_and_slide()
	print("range: " + str(target_position.distance_squared_to(self_position) < parent.data.attack_range * parent.data.attack_range))
	print("can attack: " + str(parent.can_attack))
	if target_position.distance_squared_to(self_position) < parent.data.attack_range * parent.data.attack_range and parent.can_attack:
		finished.emit(ATTACK_PROJECTILE)
