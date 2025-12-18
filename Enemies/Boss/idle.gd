extends State

func physics_update(_delta: float) -> void:
	if parent.attack_cooldown.is_stopped():
		finished.emit(ATTACK1)
