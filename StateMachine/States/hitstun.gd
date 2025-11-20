extends State

var data: Dictionary


func enter(new_data := { }) -> void:
	data = new_data


func physics_update(_delta: float) -> void:
	await parent.get_tree().create_timer(data.time).timeout
	finished.emit(parent.data.initial_state)
