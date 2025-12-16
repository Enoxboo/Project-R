extends Node

class_name HitboxUtil

const MANA_ZONE = preload("uid://c67wryal1n8u2")


static func spawn_zone(proj: Projectile, is_combo: bool = false) -> void:
	if is_combo:
		return

	if not Layers.is_on_layer(proj.area_2d.collision_layer, Layers.PLAYER_SPELL_OFFENSIVE):
		return
	if proj.element == "None":
		return

	proj.area_2d.set_deferred("monitoring", false)
	var zone = MANA_ZONE.instantiate()
	zone.element = proj.element
	zone.global_position = proj.global_position
	proj.get_tree().current_scene.call_deferred("add_child", zone)
	proj.call_deferred("queue_free")


static func hurt_target(hurtbox: Area2D, damage: int, direction: Vector2, stun_duration: float) -> void:
	if not hurtbox.has_method("take_damage"):
		return
	if damage <= 0:
		return

	hurtbox.take_damage(damage, direction, stun_duration)
