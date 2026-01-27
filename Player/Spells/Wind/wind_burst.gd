extends SpellStatic

const WIND_BURST = preload("uid://cta32x3lismn2")


func _init() -> void:
	cooldown = 9.0
	scene = WIND_BURST
	active_time = 1.0
	element = "Wind"


func cast(player):
	var instance = super.cast(player)
	if not instance:
		return false

	instance.global_position = player.get_global_mouse_position()
