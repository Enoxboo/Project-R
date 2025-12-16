extends SpellProjectile

const FIRE = preload("uid://b2qji8hvgq83i")


func _init() -> void:
	sprite = FIRE
	cooldown = 0.1
	speed = 500.0
	active_time = 1.0
	damage = 1
	stun_time = 0.2
	size = Vector2(10.0, 14.0)
	masks = [Layers.ENEMY_HURTBOX, Layers.MANA_ZONE, Layers.PLAYER_SPELL_OFFENSIVE, Layers.PLAYER_SPELL_UTILITY, Layers.PLAYER_PROJECTILE, Layers.WALLS]
	element = "Fire"
	destruct_on_hit = true


func cast(player):
	var proj = super.cast(player)
	if not proj:
		return false

	proj.timer.timeout.connect(func(): HitboxUtil.spawn_zone(proj, false))
