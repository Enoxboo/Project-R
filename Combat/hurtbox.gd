extends Area2D

signal hit_received(direction: Vector2, time: float)


func take_damage(amount: int, direction: Vector2, stun_duration: float) -> void:
	print("ON-HIT : Before health = " + str(get_parent().current_health))
	get_parent().current_health = max(0, get_parent().current_health - amount)
	print("ON-HIT : New health = " + str(get_parent().current_health))
	var stun_time: float = max(0, stun_duration - get_parent().data.stun_resistance)
	emit_signal("hit_received", direction, stun_time)
	if get_parent().current_health == 0:
		get_parent().queue_free()


func burn(amount: int, damage: int):
	for time in amount:
		get_parent().sprite.modulate = "RED"
		get_parent().current_health = max(0, get_parent().current_health - damage)
		await get_tree().create_timer(0.3).timeout
		get_parent().sprite.modulate = "WHITE"
		await get_tree().create_timer(0.7).timeout
