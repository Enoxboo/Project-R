extends State

func physics_update(_delta: float) -> void:
	parent.velocity = (parent.player.global_position - parent.global_position).normalized() * parent.data.speed
	parent.move_and_slide()
