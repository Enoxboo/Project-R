class_name ProjectileHelper

const PROJECTILE = preload("uid://cl3jxyqt80hkg")

static func throw(parent, sprite, speed, time, is_ally, damage):
	var proj = PROJECTILE.instantiate()
	proj.sprite_texture = sprite
	proj.speed = speed
	proj.traveling_time = time
	proj.is_ally = is_ally
	proj.damage = damage
	proj.stun_duration = parent.data.stun_duration
	proj.global_position = parent.global_position
	proj.direction = (parent.get_global_mouse_position() - parent.global_position).normalized()
	parent.get_parent().add_child(proj)
	return proj
