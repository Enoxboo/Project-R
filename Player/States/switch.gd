extends State

func enter() -> void:
	switch_character()
	finished.emit(MOVE)


func switch_character() -> void:
	parent.is_main_active = !parent.is_main_active
	parent.data = parent.MAIN_DATA if parent.is_main_active else parent.ELEANOR_DATA
	parent.sprite.texture = parent.data.sprite
