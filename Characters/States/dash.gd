extends CharacterState

func enter() -> void:
	character.can_dash = false
	var input_dir = character.get_input_direction()
	var dash_direction: Vector2
	if input_dir:
		dash_direction = input_dir
	else: 
		dash_direction = character.last_direction
	character.dash_duration_timer.start()
	character.dash_cooldown_timer.start()
	character.velocity = dash_direction * character.data.dash_force

func physics_update(_delta: float) -> void:
	character.move_and_slide()


func _on_dash_duration_timer_timeout() -> void:
	finished.emit(MOVE)


func _on_dash_cooldown_timer_timeout() -> void:
	character.can_dash = true
