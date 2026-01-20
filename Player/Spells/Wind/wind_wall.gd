extends SpellProjectile

const WIND = preload("uid://c2vcprt14i77g")


func _init() -> void:
	super._init()
	
	cooldown = 2.0
	active_time = 10.0
	element = "Wind"
	mana_cost = 1
	
	spell_config.sprite = WIND
	spell_config.speed = 50.0
	spell_config.damage = 0
	spell_config.stun_duration = 0
	spell_config.size = Vector2(6.0, 30.0)
	spell_config.collision_layer = Layers.PLAYER_SPELL_OFFENSIVE
	spell_config.collision_masks = [
		Layers.ENEMY_PROJECTILE, 
		Layers.MANA_ZONE, 
		Layers.PLAYER_SPELL_OFFENSIVE, 
		Layers.PLAYER_SPELL_UTILITY, 
		Layers.PLAYER_PROJECTILE, 
		Layers.WALLS]
	spell_config.destruct_on_hit = false

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
