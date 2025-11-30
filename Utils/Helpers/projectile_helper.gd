class_name ProjectileHelper

const PROJECTILE = preload("uid://cl3jxyqt80hkg")


static func throw(parent, sprite, size, speed, time, is_ally, damage, stun, is_attack, element):
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
	if element:
		proj.add_to_group("Spell" + element)
	else:
		proj.add_to_group("Projectile")
	return proj
