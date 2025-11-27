class_name ProjectileHelper

const PROJECTILE = preload("uid://cl3jxyqt80hkg")


static func throw(parent, sprite, size, speed, time, is_ally, damage, stun, is_attack):
	var proj = PROJECTILE.instantiate()
	var target: Vector2
	proj.sprite_texture = sprite
	proj.speed = speed
	proj.traveling_time = time
	proj.is_ally = is_ally
	proj.damage = damage
	proj.stun_duration = stun
	proj.global_position = parent.global_position
	target = parent.get_global_mouse_position() if is_ally else parent.player.global_position
	proj.direction = (target - parent.global_position).normalized()
	proj.is_attack = is_attack
	parent.get_parent().add_child(proj)
	proj.set_collision_size(size)
	return proj
