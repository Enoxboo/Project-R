extends SpellStatic

const FIRE_CAGE = preload("uid://defbmy8fpr7s2")


func _init() -> void:
	cooldown = 10.0
	scene = FIRE_CAGE
	active_time = 10.0
	element = "Fire"


func cast(player):
	var instance = super.cast(player)
	if not instance:
		return false

	instance.global_position = player.position
