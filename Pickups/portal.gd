extends Area2D

@export var target_scene: String = "room"

func _on_body_entered(body):
	if body.is_in_group("Player"):
		GameData.player_health = body.current_health
		GameData.player_mana = body.current_mana
		GameData.equipped_spell_1 = body.spell1_instance
		GameData.equipped_spell_2 = body.spell2_instance
		GameData.companion_data = body.companion_data
	if target_scene == "hub":
		get_tree().call_deferred("change_scene_to_file", "res://Levels/" + target_scene+ ".tscn")
	else:
		get_tree().call_deferred("change_scene_to_file", "res://Levels/" + target_scene + "_" + str(GameData.next_room) + ".tscn")
