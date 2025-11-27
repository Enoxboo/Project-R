extends State

func enter(_data := { }) -> void:
	await attack()
	finished.emit(CHASE)

func physics_update(_delta: float) -> void:
	parent.move_and_slide()

func attack() -> void:
	parent.can_attack = false
	parent.attack_cooldown.start()
	parent.velocity = Vector2.ZERO
	ProjectileHelper.throw(parent, parent.data.attack_sprite, parent.data.projectile_speed, parent.data.projectile_time, parent.data.ally, parent.data.damage, parent.data.projectile_stun)
	await get_tree().create_timer(1.5).timeout
