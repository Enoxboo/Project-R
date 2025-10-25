extends CharacterState

func physics_update(delta: float) -> void:
	var input_dir = character.get_input_direction()
	if input_dir != Vector2.ZERO:
		var target_velocity: Vector2 = input_dir * character.data.speed
		character.velocity = character.velocity.move_toward(target_velocity, character.data.acceleration * delta)
		character.last_direction = input_dir
	else:
		character.velocity = character.velocity.move_toward(Vector2.ZERO, character.data.friction * delta)
	character.move_and_slide()

	if Input.is_action_just_pressed("dash") and character.can_dash == true:
		finished.emit(DASH)
