class_name ProjectileHelper

const PROJECTILE = preload("uid://cl3jxyqt80hkg")


static func throw(parent, sprite, size, speed, time, is_ally, layer_type: int, masks: Array, damage, stun, is_attack, element):
	var proj = PROJECTILE.instantiate()
	var target: Vector2

	proj.sprite_texture = sprite
	proj.speed = speed
	proj.traveling_time = time
	proj.is_ally = is_ally
	proj.damage = damage
	proj.stun_duration = stun
	target = parent.get_global_mouse_position() if is_ally else parent.player.global_position
	proj.direction = (target - parent.global_position).normalized()
	proj.look_at(proj.position + proj.direction)
	proj.is_attack = is_attack
	proj.global_position = parent.global_position
	parent.get_parent().add_child(proj)
	proj.set_collision_size(size)
	proj.area_2d.collision_layer = 0
	proj.area_2d.collision_mask = 0
	proj.area_2d.set_collision_layer_value(layer_type, true)
	if element:
		proj.add_to_group("Spell" + element)
	for mask in masks:
		proj.area_2d.set_collision_mask_value(mask, true)

	return proj
