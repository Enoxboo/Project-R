extends SpellProjectile

const WIND = preload("uid://c2vcprt14i77g")


func _init() -> void:
	cooldown = 2.0
	speed = 50.0
	active_time = 10.0
	damage = 0
	stun_time = 0
	size = Vector2(6.0, 30.0)
	masks = [Layers.ENEMY_PROJECTILE, Layers.MANA_ZONE, Layers.PLAYER_SPELL_OFFENSIVE, Layers.PLAYER_SPELL_UTILITY, Layers.PLAYER_PROJECTILE, Layers.WALLS]
	element = "Wind"
	destruct_on_hit = false


func _on_area_entered(area: Area2D) -> void:
	call_deferred("on_hit", area)


func on_hit(area: Area2D) -> void:
	if Layers.is_on_layer(area.collision_layer, Layers.ENEMY_PROJECTILE):
		area.get_parent().queue_free()


func cast(player):
	var proj = super.cast(player)
	if not proj:
		return false

	proj.area_2d.area_entered.connect(_on_area_entered)
