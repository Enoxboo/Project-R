extends Moveset

const SPELLS = preload("uid://coxir11tq0h7h")

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
	if player.spells[1] == "":
		return
	
	if player.spells[1] == "FIRE":
		var fire = SPELLS.instantiate()
		fire.global_position = player.global_position
		player.get_parent().add_child(fire)
