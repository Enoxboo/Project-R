extends State

var masks = [Layers.PLAYER_HURTBOX, Layers.MANA_ZONE, Layers.WALLS]
var destruct_on_hit = true
var burst_count: int = 10

func enter(_data := {}) -> void:
	parent.attack_cooldown.wait_time = randf_range(1.0, 2.0)
	await attack()
	finished.emit(IDLE)

func attack() -> void:
	for x in burst_count:
		ProjectileHelper.throw(parent, parent.data.attack_sprite, parent.data.attack_size, parent.data.projectile_speed, parent.data.projectile_time, parent.data.ALLY, Layers.ENEMY_PROJECTILE, masks, parent.data.damage, parent.data.projectile_stun, "None", destruct_on_hit)
		await get_tree().create_timer(0.2).timeout
	await get_tree().create_timer(1.5).timeout
