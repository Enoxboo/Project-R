extends Node

class_name StateMachine

var state: State


func _ready() -> void:
	state = get_child(0)
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)

	await owner.ready
	owner.hurtbox.hit_received.connect(_on_hit_received)
	state.enter()


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func _transition_to_next_state(target_state_path: String, data: Dictionary = { }) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	state.exit()
	state = get_node(target_state_path)
	state.enter(data)


func _on_hit_received(direction: Vector2, time: float) -> void:
	_flash_red()
	
	if not owner.is_in_group("Boss"):
		var data: Dictionary = { "direction": direction, "time": time }
		_transition_to_next_state(state.HITSTUN, data)

func _flash_red() -> void:
	owner.sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	owner.sprite.modulate = Color.WHITE
