extends Spell

const FIRE = preload("uid://b2qji8hvgq83i")
const MANA_ZONE = preload("uid://c67wryal1n8u2")

var fireball_speed: float = 500.0
var fireball_time: float = 1.0
var ally: bool = true
var damage: int = 1
var fireball_stun: float = 0.2
var cooldown: float = 3.0
var size: Vector2 = Vector2(10.0, 14.0)

func _on_area_entered(area: Area2D) -> void:
	call_deferred("_spawn_zone", area)

func _spawn_zone(area: Area2D) -> void:
	var zone = MANA_ZONE.instantiate()
	zone.element = "Fire"
	area.get_tree().current_scene.add_child(zone)
	zone.global_position = area.global_position

func apply_spell(projectile: Projectile) -> void:
	print("Position:", projectile.global_position)
	var zone = MANA_ZONE.instantiate()
	zone.element = "Fire"
	projectile.get_tree().current_scene.add_child(zone)
	zone.global_position = projectile.global_position

func cast(player) -> bool:
	if not super.cast(player):
		return false

	player.current_mana -= mana_cost
	print(player.current_mana)
	
	var proj = ProjectileHelper.throw(player, FIRE, size, fireball_speed, fireball_time, ally, damage, fireball_stun, true)
	proj.area_2d.area_entered.connect(_on_area_entered)
	proj.timer.timeout.connect(func(): apply_spell(proj))

	return true
