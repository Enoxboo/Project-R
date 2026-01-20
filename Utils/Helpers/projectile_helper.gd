class_name ProjectileHelper

const PROJECTILE = preload("uid://cl3jxyqt80hkg")


static func throw(parent: Node2D, config: ProjectileConfig):
	var proj = PROJECTILE.instantiate()
	var target: Vector2
	
	proj.sprite_texture = config.sprite
	proj.speed = config.speed
	proj.traveling_time = config.traveling_time
	proj.is_ally = config.is_ally
	proj.damage = config.damage
	proj.stun_duration = config.stun_duration
	proj.element = config.element
	proj.destruct_on_hit = config.destruct_on_hit
	
	target = parent.get_global_mouse_position() if config.is_ally else parent.player.global_position
	proj.direction = (target - parent.global_position).normalized()
	proj.look_at(proj.position + proj.direction)
	proj.global_position = parent.global_position
	
	parent.get_parent().add_child(proj)
	proj.set_collision_size(config.size)
	
	proj.area_2d.collision_layer = 0
	proj.area_2d.collision_mask = 0
	proj.area_2d.set_collision_layer_value(config.collision_layer, true)
	
	for mask in config.collision_masks:
		proj.area_2d.set_collision_mask_value(mask, true)
	
	return proj
