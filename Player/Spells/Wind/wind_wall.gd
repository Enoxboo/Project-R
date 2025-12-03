extends Spell

const WIND = preload("uid://c2vcprt14i77g")


func _init() -> void:
	speed = 50.0
	active_time = 10.0
	damage = 0
	stun_time = 0
	size = Vector2(6.0, 30.0)
	masks = [Layers.ENEMY_PROJECTILE, Layers.MANA_ZONE, Layers.PLAYER_SPELL_OFFENSIVE, Layers.PLAYER_SPELL_UTILITY, Layers.PLAYER_PROJECTILE, Layers.WALLS]


func _ready() -> void:
	speed = 50.0
	active_time = 10.0
	damage = 0
	stun_time = 0
	size = Vector2(6.0, 30.0)
	super._ready()


func _on_area_entered(area: Area2D) -> void:
	print(area.collision_layer)
	print(Layers.ENEMY_PROJECTILE)
	print(Layers.is_on_layer(area.collision_layer, Layers.ENEMY_PROJECTILE))
	if Layers.is_on_layer(area.collision_layer, Layers.ENEMY_PROJECTILE):
		area.get_parent().queue_free()


func cast(player) -> bool:
	if not super.cast(player):
		return false

	player.current_mana -= mana_cost
	emit_signal("mana_changed")

	var proj = ProjectileHelper.throw(player, WIND, size, speed, active_time, ally, Layers.PLAYER_SPELL_UTILITY, masks, damage, stun_time, false, "Wind")
	proj.area_2d.area_entered.connect(_on_area_entered)

	return true
