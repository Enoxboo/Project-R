extends State

func physics_update(_delta: float) -> void:
	handle_movement()
	parent.move_and_slide()

	if Input.is_action_just_pressed("switch"):
		finished.emit(SWITCH)


func handle_movement() -> void:
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	parent.velocity = input_direction * parent.data.speed
