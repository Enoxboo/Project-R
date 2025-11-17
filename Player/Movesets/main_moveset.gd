extends Moveset

func _perform_attack(player: Player) -> void:
	player.can_attack = false
	player.hitbox.monitoring = true
	player.hitbox_sprite.visible = true
	player.hitbox.position.x = player.data.attack_offset


func _end_attack(player: Player) -> void:
	player.hitbox.monitoring = false
	player.hitbox_sprite.visible = false
	player.hitbox.position.x = 0
