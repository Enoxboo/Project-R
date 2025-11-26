extends Spell

const FIRE_BALL = preload("uid://d4d0800xuv8cg")
const FIRE = preload("uid://b2qji8hvgq83i")

const fireball_speed: float = 1000.0
const fireball_time: float = 10.0
const ally: bool = true
var damage: int = 1

func _on_area_entered(area: Area2D) -> void:
	print("brulé")
	area.get_parent().sprite.modulate = "RED"

func cast(player) -> void:
	ProjectileHelper.throw(player, FIRE, fireball_speed, fireball_time, ally, damage)
