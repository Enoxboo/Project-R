extends State

func enter(_data := { }) -> void:
	parent.attack_cooldown.start()

func physics_update(_delta: float) -> void:
	if parent.attack_cooldown.is_stopped():
		finished.emit(ATTACK1)
