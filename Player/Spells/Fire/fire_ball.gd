extends Spell

const FIRE_SPRITE = preload("uid://b2qji8hvgq83i")
const MANA_ZONE = preload("uid://c67wryal1n8u2")


func _init() -> void:
	speed = 500.0
	active_time = 1.0
	damage = 1
	stun_time = 0.2
	size = Vector2(10.0, 14.0)
	masks = [Layers.ENEMY_HURTBOX, Layers.MANA_ZONE, Layers.PLAYER_SPELL_OFFENSIVE, Layers.PLAYER_SPELL_UTILITY, Layers.PLAYER_PROJECTILE, Layers.WALLS]
	element = "Fire"

func _on_area_entered(area: Area2D, proj: Projectile) -> void:
	call_deferred("on_hit", area, proj)


func on_hit(area: Area2D, proj: Projectile) -> void:
	if area.get_parent().is_in_group("Enemy"):
		spawn_zone(area)
	elif Layers.is_on_layer(area.collision_layer, Layers.PLAYER_SPELL_OFFENSIVE) or Layers.is_on_layer(area.collision_layer, Layers.PLAYER_SPELL_UTILITY) or Layers.is_on_layer(area.collision_layer, Layers.MANA_ZONE):
		ComboManager.check_combo(area, proj)
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
	player.emit_signal("mana_changed")

	var proj = ProjectileHelper.throw(player, FIRE_SPRITE, size, speed, active_time, ally, Layers.PLAYER_SPELL_OFFENSIVE, masks, damage, stun_time, true, element)
	proj.area_2d.area_entered.connect(func(area): _on_area_entered(area, proj))
	proj.timer.timeout.connect(func(): apply_spell(proj))
	
	return true
