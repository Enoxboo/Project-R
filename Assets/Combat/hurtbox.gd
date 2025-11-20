extends Area2D

func take_damage(amount: int) -> void:
	get_parent().current_health = max(0, get_parent().current_health - amount)
	print("New health = " + str(get_parent().current_health))
