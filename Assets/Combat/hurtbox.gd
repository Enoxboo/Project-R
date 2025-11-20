extends Area2D

signal hit_received(direction: Vector2, time: float)


func take_damage(amount: int, direction: Vector2, stun_duration: float) -> void:
	get_parent().current_health = max(0, get_parent().current_health - amount)
	print("New health = " + str(get_parent().current_health))
	var stun_time: float = max(0, stun_duration - get_parent().data.stun_resistance)
	emit_signal("hit_received", direction, stun_time)
