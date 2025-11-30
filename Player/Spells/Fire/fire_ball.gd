extends Spell

const FIRE = preload("uid://b2qji8hvgq83i")
const MANA_ZONE = preload("uid://c67wryal1n8u2")


func _init() -> void:
	speed = 500.0
	active_time = 1.0
	damage = 1
	stun_time = 0.2
	size = Vector2(10.0, 14.0)


func _on_area_entered(area: Area2D, proj: Projectile) -> void:
	call_deferred("on_hit", area, proj)


func on_hit(area: Area2D, proj: Projectile) -> void:
	if area.owner.is_in_group("Enemy"):
		spawn_zone(area)
	elif area.owner.is_in_group("SpellWind"):
		ComboManager.fire_tornado(proj)
		area.owner.queue_free()
		proj.queue_free()


func apply_spell(projectile: Projectile) -> void:
	spawn_zone(projectile)


func spawn_zone(parent: Node2D) -> void:
	var zone = MANA_ZONE.instantiate()
	zone.element = "Fire"
	parent.get_tree().current_scene.add_child(zone)
	zone.global_position = parent.global_position


func cast(player) -> bool:
	if not super.cast(player):
		return false

	player.current_mana -= mana_cost
	emit_signal("mana_changed")

	var proj = ProjectileHelper.throw(player, FIRE, size, speed, active_time, ally, damage, stun_time, true, "Fire")
	proj.area_2d.area_entered.connect(func(area): _on_area_entered(area, proj))
	proj.timer.timeout.connect(func(): apply_spell(proj))

	return true
