extends SpellProjectile

const FIRE = preload("uid://b2qji8hvgq83i")

func _init() -> void:
	super._init()
	
	cooldown = 2.0
	active_time = 1.0
	element = "Fire"
	mana_cost = 1
	
	spell_config.sprite = FIRE
	spell_config.speed = 500.0
	spell_config.damage = 1
	spell_config.stun_duration = 0.2
	spell_config.size = Vector2(10.0, 14.0)
	spell_config.collision_layer = Layers.PLAYER_SPELL_OFFENSIVE
	spell_config.collision_masks = [
		Layers.ENEMY_HURTBOX,
		Layers.MANA_ZONE,
		Layers.PLAYER_SPELL_OFFENSIVE,
		Layers.PLAYER_SPELL_UTILITY,
		Layers.PLAYER_PROJECTILE,
		Layers.WALLS
	]
	spell_config.destruct_on_hit = true

func cast(player):
	var proj = super.cast(player)
	if not proj:
		return false

	proj.timer.timeout.connect(func(): HitboxUtil.spawn_zone(proj, false))
	return true
