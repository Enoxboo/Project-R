extends State

enum AttackVariant { SINGLE, TRIPLE, LINE, CROSS }

var warning_time: float = 0.8
var active_time: float = 0.25

func enter(_data := { }) -> void:
	parent.attack_cooldown.wait_time = randf_range(1.0, 2.0)
	await attack()
	finished.emit(IDLE)

func attack() -> void:
	parent.hitbox_attack_1.global_position = parent.player.global_position
	parent.hitbox_attack_1.visible = true
	parent.hitbox_attack_1.modulate = Color(1, 1, 1, 0.5)
	parent.hitbox_attack_1.monitoring = false
	await get_tree().create_timer(warning_time).timeout
	parent.hitbox_attack_1.modulate = Color.RED
	parent.hitbox_attack_1.monitoring = true
	await get_tree().create_timer(active_time).timeout
	parent.hitbox_attack_1.visible = false
	parent.hitbox_attack_1.monitoring = false
	parent.hitbox_attack_1.global_position = parent.global_position
	parent.hitbox_attack_1.modulate = Color.WHITE

#func _screen_shake(intensity: float) -> void:
	#if parent.has_node("/root/Room1/Camera2D"):
		#var camera: Camera2D = parent.get_node("/root/Main/Camera2D")
		#var original_offset: Vector2 = camera.offset
		#
		#for i in 3:
			#camera.offset = original_offset + Vector2(
				#randf_range(-intensity, intensity),
				#randf_range(-intensity, intensity)
			#)
			#await get_tree().create_timer(0.05).timeout
		#
		#camera.offset = original_offset
