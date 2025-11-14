class_name Moveset

func attack(player: Player) -> void:
	if !player.can_attack:
		return

	player.can_attack = false

	_perform_attack(player)

	await player.get_tree().create_timer(player.data.attack_active).timeout
	_end_attack(player)

	await player.get_tree().create_timer(player.data.attack_rest).timeout
	player.can_attack = true


func reset_attack(player: Player) -> void:
	_end_attack(player)


func _perform_attack(_player: Player) -> void:
	pass


func _end_attack(_player: Player) -> void:
	pass


func spell_1(_player: Player) -> void:
	pass


func spell_2(_player: Player) -> void:
	pass
