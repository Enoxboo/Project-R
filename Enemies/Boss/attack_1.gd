extends State

var base_warning_time: float = 0.5
var active_time: float = 0.2

func enter(_data := {}) -> void:
	parent.attack_cooldown.wait_time = randf_range(1.0, 2.0)
	await attack()
	finished.emit(IDLE)

func attack() -> void:
	var health_percent = float(parent.current_health) / float(parent.data.max_health)
	var warning_time = base_warning_time * max(0.5, health_percent)
	
	var attack_position = parent.player.global_position
	parent.hitbox_attack_1.global_position = attack_position
	parent.hitbox_attack_1.visible = true
	parent.hitbox_attack_1.modulate = Color.WHITE
	parent.hitbox_attack_1.monitoring = false
	
	parent.attack_1_sprite.modulate = Color(1, 1, 1, 0.5)
	var warning_circle = parent.hitbox_attack_1.get_node("WarningCircle")
	warning_circle.modulate = Color(1, 1, 1, 0.5)
	
	var circle_pulse = create_tween().set_loops()
	circle_pulse.tween_property(warning_circle, "modulate:a", 0.3, 0.3)
	circle_pulse.tween_property(warning_circle, "modulate:a", 0.6, 0.3)
	
	var cross_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	cross_tween.tween_property(parent.attack_1_sprite, "scale", Vector2.ONE, warning_time)
	
	var rotation_tween = create_tween()
	rotation_tween.tween_property(parent.attack_1_sprite, "rotation", deg_to_rad(45), warning_time)

	parent.get_node("HitboxAttack1/WarningParticles").emitting = true
	
	await cross_tween.finished
	circle_pulse.kill()
	
	parent.get_node("HitboxAttack1/WarningParticles").emitting = false
	
	var flash_tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD).set_parallel(true)
	flash_tween.tween_property(parent.attack_1_sprite, "modulate", Color.RED, 0.08)
	flash_tween.tween_property(warning_circle, "modulate", Color.RED, 0.08)
	
	var impact_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	impact_tween.tween_property(parent.attack_1_sprite, "scale", Vector2.ONE * 1.3, 0.15)
	impact_tween.tween_property(parent.attack_1_sprite, "scale", Vector2.ONE, 0.1)
	

	var impact_particles = parent.get_node("HitboxAttack1/ImpactParticles")
	impact_particles.emitting = false
	await get_tree().process_frame
	impact_particles.restart()
	impact_particles.emitting = true
	
	parent.hitbox_attack_1.monitoring = true
	await get_tree().create_timer(active_time).timeout
	
	
	parent.hitbox_attack_1.monitoring = false
	
	var fade_tween = create_tween().set_parallel(true)
	fade_tween.tween_property(parent.attack_1_sprite, "modulate:a", 0.0, 0.25)
	fade_tween.tween_property(parent.attack_1_sprite, "scale", Vector2.ZERO, 0.25)
	fade_tween.tween_property(warning_circle, "modulate:a", 0.0, 0.25)
	
	await fade_tween.finished
	
	parent.hitbox_attack_1.visible = false
	parent.hitbox_attack_1.global_position = parent.global_position
	parent.attack_1_sprite.modulate = Color.WHITE
	parent.attack_1_sprite.scale = Vector2(0.01, 0.01)
	parent.attack_1_sprite.rotation = 0.0
	warning_circle.modulate = Color.WHITE
