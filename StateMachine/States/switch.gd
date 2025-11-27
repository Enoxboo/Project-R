extends State

func enter(_data := { }) -> void:
	if parent.companion_data and parent.can_switch:
		switch_character()
	finished.emit(MOVE)


func switch_character() -> void:
	parent.can_switch = false
	parent.switch_timer.start()
	parent.moveset_instance.reset_attack(parent)
	parent.can_attack = true
	parent.is_main_active = !parent.is_main_active
	parent.data = parent.MAIN_DATA if parent.is_main_active else parent.companion_data
	parent.sprite.texture = parent.data.sprite
	parent.moveset_instance = parent.data.moveset.new()
