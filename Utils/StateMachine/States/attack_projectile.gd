extends State

var projectile_config: ProjectileConfig

func _ready() -> void:
	_setup_projectile_config()

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


func enter(_data := { }) -> void:
	await attack()
	finished.emit(CHASE)


func physics_update(_delta: float) -> void:
	parent.move_and_slide()


func attack() -> void:
	parent.can_attack = false
	parent.attack_cooldown.start()
	parent.velocity = Vector2.ZERO
	ProjectileHelper.throw(parent, projectile_config)
	await get_tree().create_timer(1.5).timeout
