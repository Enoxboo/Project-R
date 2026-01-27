extends State

var projectile_config: ProjectileConfig
var burst_count: int = 10
var _is_setup: bool = false

func enter(_data := {}) -> void:
	if not _is_setup:
		_setup_projectile_config()
		_is_setup = true
	
	parent.attack_cooldown.wait_time = randf_range(1.0, 2.0)
	await attack()
	finished.emit(IDLE)

func _setup_projectile_config() -> void:
	projectile_config = ProjectileConfig.new()
	projectile_config.sprite = parent.data.attack_sprite
	projectile_config.size = parent.data.attack_size
	projectile_config.speed = parent.data.projectile_speed
	projectile_config.traveling_time = parent.data.projectile_time
	projectile_config.is_ally = parent.data.ALLY
	projectile_config.collision_layer = Layers.ENEMY_PROJECTILE
	projectile_config.collision_masks = [
		Layers.PLAYER_HURTBOX,
		Layers.MANA_ZONE,
		Layers.WALLS
	]
	projectile_config.damage = parent.data.damage
	projectile_config.stun_duration = parent.data.projectile_stun
	projectile_config.element = "None"
	projectile_config.destruct_on_hit = true

func attack() -> void:
	for x in burst_count:
		ProjectileHelper.throw(parent, projectile_config)
		await get_tree().create_timer(0.2).timeout
	await get_tree().create_timer(1.5).timeout
