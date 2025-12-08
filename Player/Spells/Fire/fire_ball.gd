extends Spell

const FIRE_SPRITE = preload("uid://b2qji8hvgq83i")


func _init() -> void:
	speed = 500.0
	active_time = 1.0
	damage = 1
	stun_time = 0.2
	size = Vector2(10.0, 14.0)
	masks = [Layers.ENEMY_HURTBOX, Layers.MANA_ZONE, Layers.PLAYER_SPELL_OFFENSIVE, Layers.PLAYER_SPELL_UTILITY, Layers.PLAYER_PROJECTILE, Layers.WALLS]
	element = "Fire"
	destruct_on_hit = true


func cast(player) -> bool:
	if not super.cast(player):
		return false

	player.current_mana -= mana_cost
	player.emit_signal("mana_changed")

	var proj = ProjectileHelper.throw(player, FIRE_SPRITE, size, speed, active_time, ally, Layers.PLAYER_SPELL_OFFENSIVE, masks, damage, stun_time, element, destruct_on_hit)
	proj.timer.timeout.connect(func(): HitboxUtil.spawn_zone(proj, false))

	return true
