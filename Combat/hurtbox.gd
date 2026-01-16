extends Area2D

signal hit_received(direction: Vector2, time: float)
signal health_changed(new_health: int)


func take_damage(amount: int, direction: Vector2, stun_duration: float) -> void:
	var parent = get_parent()
	print("ON-HIT : Before health = " + str(parent.current_health))
	parent.current_health = max(0, parent.current_health - amount)
	emit_signal("health_changed", parent.current_health)
	print("ON-HIT : New health = " + str(parent.current_health))
	
	var stun_resistance: float = get_parent().get_stun_resistance()
	var stun_time: float = max(0, stun_duration - stun_resistance)
	
	emit_signal("hit_received", direction, stun_time)
	if parent.current_health == 0:
		parent.queue_free()


func burn(amount: int, damage: int):
	for time in amount:
		get_parent().sprite.modulate = "RED"
		get_parent().current_health = max(0, get_parent().current_health - damage)
		emit_signal("health_changed", get_parent().current_health)
		await get_tree().create_timer(0.3).timeout
		get_parent().sprite.modulate = "WHITE"
		await get_tree().create_timer(0.7).timeout
