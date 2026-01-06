extends State

var warning_time: float = 0.5
var active_time: float = 0.2

func enter(_data := {}) -> void:
	parent.attack_cooldown.wait_time = randf_range(1.0, 2.0)
	await attack()
	finished.emit(IDLE)

func attack() -> void:
	parent.hitbox_attack_1.global_position = parent.player.global_position
	parent.hitbox_attack_1.visible = true
	
	await get_tree().create_timer(warning_time).timeout
	
	print(parent.attack_1_sprite.modulate)
	parent.hitbox_attack_1.modulate = Color(1, 0, 0, 1)
	print(parent.attack_1_sprite.modulate)
	parent.hitbox_attack_1.monitoring = true
	
	await get_tree().create_timer(active_time).timeout
	
	parent.hitbox_attack_1.modulate = Color(1, 1, 1, 1)
	parent.hitbox_attack_1.monitoring = false
	parent.hitbox_attack_1.visible = false
