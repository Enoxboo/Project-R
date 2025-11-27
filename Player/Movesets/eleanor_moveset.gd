extends Moveset

const PROJECTILE = preload("uid://cl3jxyqt80hkg")
const ARROW = preload("uid://uponwqt1ncca")
const arrow_speed: float = 1000.0
const arrow_time: float = 10.0
const ally: bool = true
var damage: int = 1
var arrow_stun: float = 1.0

func _perform_attack(player: Player) -> void:
	ProjectileHelper.throw(player, ARROW, arrow_speed, arrow_time, ally, damage, arrow_stun)


func _end_attack(_player: Player) -> void:
	print("fin")
