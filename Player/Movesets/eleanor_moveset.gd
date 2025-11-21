extends Moveset

const PROJECTILE = preload("uid://cl3jxyqt80hkg")
const ARROW = preload("uid://uponwqt1ncca")
const arrow_speed: float = 1000.0
const arrow_time: float = 10.0
const ally: bool = true
var damage: int = 1


func _perform_attack(player: Player) -> void:
	var projectile = PROJECTILE.instantiate()
	projectile.sprite_texture = ARROW
	projectile.speed = arrow_speed
	projectile.traveling_time = arrow_time
	projectile.is_ally = ally
	projectile.damage = damage
	projectile.stun_duration = player.data.stun_duration
	projectile.global_position = player.global_position
	projectile.direction = (player.get_global_mouse_position() - player.global_position).normalized()
	player.get_parent().add_child(projectile)


func _end_attack(_player: Player) -> void:
	print("fin")
