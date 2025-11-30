extends Moveset

const PROJECTILE = preload("uid://cl3jxyqt80hkg")
const ARROW = preload("uid://uponwqt1ncca")
var arrow_speed: float = 1000.0
var arrow_time: float = 10.0
const ALLY: bool = true
var damage: int = 1
var arrow_stun: float = 1.0
var size: Vector2 = Vector2(10.0, 2.0)


func _perform_attack(player: Player) -> void:
	ProjectileHelper.throw(player, ARROW, size, arrow_speed, arrow_time, ALLY, damage, arrow_stun, true, null)


func _end_attack(_player: Player) -> void:
	print("fin")
