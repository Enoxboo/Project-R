extends State


func enter(_data := { }) -> void:
	parent.attack_cooldown.wait_time = randf_range(1.0, 2.0)
	await attack()
	finished.emit(IDLE)

func attack() -> void:
	parent.hitbox_attack_1.global_position = parent.player.global_position
	parent.hitbox_attack_1.visible = true
	await get_tree().create_timer(1.0).timeout
	parent.hitbox_attack_1.modulate = Color.RED
	parent.hitbox_attack_1.monitoring = true
	await get_tree().create_timer(1.0).timeout
	parent.hitbox_attack_1.visible = false
	parent.hitbox_attack_1.monitoring = false
	parent.hitbox_attack_1.global_position = parent.global_position
	parent.hitbox_attack_1.modulate = Color.WHITE
