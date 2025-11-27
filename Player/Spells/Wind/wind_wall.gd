extends Spell

const WIND = preload("uid://c2vcprt14i77g")

var windwall_speed: float = 50.0
var windwall_time: float = 10.0
var ally: bool = true
var damage: int = 0
var windwall_stun: float = 0
var cooldown: float = 3.0
var size: Vector2 = Vector2(6.0, 30.0)

func _on_area_entered(area: Area2D) -> void:
	area.owner.queue_free()

func cast(player) -> bool:
	if not super.cast(player):
		return false

	player.current_mana -= mana_cost
	print(player.current_mana)

	var proj = ProjectileHelper.throw(player, WIND, size, windwall_speed, windwall_time, ally, damage, windwall_stun, false)
	proj.area_2d.area_entered.connect(_on_area_entered)
	print(proj.area_2d.collision_layer)
	print(proj.area_2d.collision_mask)

	return true
