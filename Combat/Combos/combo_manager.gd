extends Node

class_name ComboManager

const FIRE_TORNADO = preload("uid://crt450wflde7u")


static func process_magic_interaction(area: Area2D, proj: Projectile) -> void:
	if not Layers.is_magical(area.collision_layer):
		return
	var zone_element: String = _get_element_from_area(area)
	if zone_element == "":
		return

	var other_proj = _get_projectile_from_area(area)
	if other_proj:
		if proj.get_instance_id() > other_proj.get_instance_id():
			proj.queue_free()
			return

	if proj.element == "None":
		_imbue(proj, zone_element)
	else:
		_try_combo(proj.element, zone_element, proj)


static func _get_element_from_area(area: Area2D) -> String:
	if area is ManaZone:
		return area.element

	var parent = area.get_parent()
	if parent is Projectile or SpellStatic:
		return parent.element

	return ""


static func _get_projectile_from_area(area: Area2D) -> Projectile:
	var parent = area.get_parent()
	if parent is Projectile:
		return parent
	return null


static func _imbue(proj: Projectile, zone_element: String) -> void:
	proj.element = zone_element
	match proj.element:
		"Fire":
			proj.sprite.modulate = "Red"
		"Wind":
			proj.sprite.modulate = "Silver"
			proj.speed *= 2
			proj.damage *= 2


static func _try_combo(proj_element: String, zone_element: String, proj: Projectile) -> void:
	var effects := {
		["Fire", "Wind"]: func(): fire_tornado(proj),
		["Wind", "Fire"]: func(): fire_tornado(proj),
		["Fire", "Fire"]: func(): print("super feu"),
		["Wind", "Wind"]: func(): print("super vent"),
	}

	var key := [zone_element, proj_element]
	if effects.has(key):
		effects[key].call()


static func fire_tornado(proj) -> void:
	var combo_instance = FIRE_TORNADO.instantiate()
	combo_instance.global_position = proj.global_position
	combo_instance.direction = proj.direction
	proj.get_parent().call_deferred("add_child", combo_instance)
	proj.call_deferred("queue_free")
