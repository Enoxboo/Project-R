extends SpellBase

class_name SpellProjectile

var spell_config: ProjectileConfig

func _init() -> void:
	spell_config = ProjectileConfig.new()

func cast(player):
	if not super.cast(player):
		return

	player.current_mana -= mana_cost
	player.emit_signal("mana_changed")

	spell_config.element = element
	spell_config.traveling_time = active_time
	spell_config.is_ally = true
	
	var proj = ProjectileHelper.throw(player, spell_config)
	return proj
