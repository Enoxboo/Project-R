extends Node

class_name ComboManager

const FIRE_TORNADO = preload("uid://s5ymxwbjo312")


static func fire_tornado(proj) -> void:
	var combo_instance = FIRE_TORNADO.instantiate()
	combo_instance.global_position = proj.global_position
	combo_instance.direction = proj.direction
	proj.get_parent().add_child(combo_instance)
