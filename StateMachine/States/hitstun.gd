extends State

var data: Dictionary

const knocback_force: float = 100.0
const knockback_time: float = 0.1
var is_stunned = false


func enter(new_data := { }) -> void:
	data = new_data
	parent.knockback_timer.stop()
	parent.stun_timer.stop()

	parent.velocity = data.direction * knocback_force
	parent.knockback_timer.wait_time = knockback_time
	parent.knockback_timer.start()

	await parent.knockback_timer.timeout
	is_stunned = true
	parent.stun_timer.wait_time = data.time
	parent.stun_timer.start()

	await parent.stun_timer.timeout
	is_stunned = false
	finished.emit(parent.data.initial_state)


func physics_update(delta: float) -> void:
	if is_stunned:
		parent.velocity = parent.velocity.move_toward(Vector2.ZERO, 500 * delta)
	parent.move_and_slide()
