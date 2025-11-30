extends State

func physics_update(_delta: float) -> void:
	if not parent.player:
		return
	
	var target_position: Vector2 = parent.player.global_position
	var self_position: Vector2 = parent.global_position
	parent.velocity = (target_position - self_position).normalized() * parent.data.speed
	parent.move_and_slide()
	if target_position.distance_squared_to(self_position) < parent.data.attack_range * parent.data.attack_range and parent.can_attack and ATTACK_PROJECTILE:
		var state_machine = parent.get_node("StateMachine")
		if state_machine.has_node(ATTACK_PROJECTILE):
			finished.emit(ATTACK_PROJECTILE)
