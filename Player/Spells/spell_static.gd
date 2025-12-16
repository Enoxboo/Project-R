extends SpellBase

class_name SpellStatic

var scene: PackedScene


func cast(player):
	if not super.cast(player):
		return

	player.current_mana -= mana_cost
	player.emit_signal("mana_changed")

	var instance = scene.instantiate()
	instance.active_time = active_time
	instance.element = element
	player.get_parent().add_child(instance)

	return instance
