extends Node

class_name ElementUtil

static func apply_element(hurtbox: Area2D, element: String) -> void:
	if not Layers.is_hurtbox(hurtbox.collision_layer):
		return

	match element:
		"Fire":
			hurtbox.burn(2, 2)
		"Wind":
			hurtbox.get_parent().wind_boost()


static func end_element(hurtbox: Area2D, element: String) -> void:
	if Layers.is_hurtbox(hurtbox.collision_layer):
		match element:
			"Wind":
				hurtbox.get_parent().end_wind_boost()
