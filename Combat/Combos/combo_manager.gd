extends Node

class_name ComboManager

const FIRE_TORNADO = preload("uid://s5ymxwbjo312")

static func check_combo(area: Area2D, proj: Projectile) -> void:
	if Layers.is_on_layer(proj.area_2d.collision_layer, Layers.PLAYER_PROJECTILE) or Layers.is_on_layer(proj.area_2d.collision_layer, Layers.ENEMY_PROJECTILE):
		check_area_element(area.element, proj)
	elif Layers.is_on_layer(area.collision_layer, Layers.PLAYER_SPELL_OFFENSIVE) or Layers.is_on_layer(area.collision_layer, Layers.PLAYER_SPELL_UTILITY):
		check_area_element(area.get_parent().element, proj)
		area.get_parent().queue_free()
		proj.queue_free()
	elif Layers.is_on_layer(area.collision_layer, Layers.MANA_ZONE):
		check_area_element(area.element, proj)
		area.queue_free()
		proj.queue_free()


static func check_area_element(area_element: String, proj: Projectile):
	if area_element == "Fire" and proj.element == "Wind":
		fire_tornado(proj)
	elif area_element == "Wind" and proj.element == "Fire":
		fire_tornado(proj)
	elif area_element == "Fire" and proj.element == "Fire":
		print("super feu")
	elif area_element == "Wind" and proj.element == "Wind":
		print("super vent")
	elif proj.element == "None":
		proj.element = area_element
		match proj.element:
			"Fire":
				proj.sprite.modulate = "Red"
			"Wind":
				proj.sprite.modulate = "Silver"
				proj.speed *= 2
				proj.damage *= 2

static func fire_tornado(proj) -> void:
	var combo_instance = FIRE_TORNADO.instantiate()
	combo_instance.global_position = proj.global_position
	combo_instance.direction = proj.direction
	proj.get_parent().add_child(combo_instance)
