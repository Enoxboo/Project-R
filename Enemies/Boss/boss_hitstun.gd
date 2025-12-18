extends State

func enter(_data := { }) -> void:
	parent.sprite.modulate = "RED"
	await get_tree().create_timer(0.3).timeout
	parent.sprite.modulate = "WHITE"
