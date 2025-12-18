extends State


func enter(_data := { }) -> void:
	parent.attack_cooldown.wait_time = randf_range(1.0, 2.0)
	parent.attack_cooldown.start()
	attack()
	finished.emit(IDLE)

func attack() -> void:
	print("attack")
	print("new timing = " + str(parent.attack_cooldown.wait_time))
