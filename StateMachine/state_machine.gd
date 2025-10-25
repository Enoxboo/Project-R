extends Node

class_name StateMachine

@export var initial_state: State = null

@onready var state: State = initial_state if initial_state else get_child(0)


func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)

	await owner.ready
	state.enter()


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func _transition_to_next_state(target_state_path: String) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	state.exit()
	state = get_node(target_state_path)
	state.enter()
