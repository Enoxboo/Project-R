extends CharacterState

func enter() -> void:
	character.can_dash = false
	
	var input_dir := character.get_input_direction()
	var dash_dir := input_dir if input_dir else character.last_direction
	
	_set_dash_particles_direction(-dash_dir)
	
	character.velocity = dash_dir * character.data.dash_force
	character.dash_duration_timer.start()
	character.dash_cooldown_timer.start()
	
	character.start_dash_particles()


func physics_update(_delta: float) -> void:
	character.move_and_slide()


func _set_dash_particles_direction(direction: Vector2) -> void:
	var material := character.dash_burst.process_material
	material.direction = Vector3(direction.x, direction.y, 0.0)


func _on_dash_duration_timer_timeout() -> void:
	finished.emit(MOVE)


func _on_dash_cooldown_timer_timeout() -> void:
	character.can_dash = true
