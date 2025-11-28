extends Spell

const FIRE = preload("uid://b2qji8hvgq83i")
const MANA_ZONE = preload("uid://c67wryal1n8u2")

var fireball_speed: float = 1000.0
var fireball_time: float = 10.0
var ally: bool = true
var damage: int = 1
var fireball_stun: float = 0.2
var cooldown: float = 3.0
var size: Vector2 = Vector2(10.0, 14.0)

func _on_area_entered(area: Area2D) -> void:
	area.burn(3, 1)
	var zone = MANA_ZONE.instantiate()
	get_parent().add_child(zone)

func cast(player) -> bool:
	if not super.cast(player):
		return false

	player.current_mana -= mana_cost
	print(player.current_mana)
	
	var proj = ProjectileHelper.throw(player, FIRE, size, fireball_speed, fireball_time, ally, damage, fireball_stun, true)
	proj.area_2d.area_entered.connect(_on_area_entered)

	return true
