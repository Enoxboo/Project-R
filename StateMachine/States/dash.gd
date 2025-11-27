extends State

func enter(_data := { }) -> void:
	if parent.can_dash:
		await dash()
	finished.emit(MOVE)

func physics_update(delta: float) -> void:
	parent.velocity = parent.velocity.move_toward(Vector2.ZERO, 500 * delta)
	parent.move_and_slide()

func dash() -> void:
	parent.can_dash = false
	parent.dash_cooldown.start()
	parent.hurtbox.monitorable = false
	
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if not input_direction:
		input_direction = (parent.get_global_mouse_position() - parent.global_position).normalized()
	parent.velocity = input_direction * parent.data.dash_force
	await get_tree().create_timer(0.2).timeout
	parent.hurtbox.monitorable = true
	
