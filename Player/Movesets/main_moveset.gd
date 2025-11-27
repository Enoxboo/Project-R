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


func spell_1(player: Player) -> void:
	if not player.spell1_instance or not player.can_spell_1:
		return

	player.spell_1_cooldown.start()
	player.can_spell_1 = false
	player.spell1_instance.cast(player)
