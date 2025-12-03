extends Area2D

@export var target_scene: String = "room"


func _on_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("Player"):
		GameData.player_health = area.owner.current_health
		GameData.player_mana = area.owner.current_mana
		GameData.equipped_spell_1 = area.owner.spell1_instance
		GameData.equipped_spell_2 = area.owner.spell2_instance
		GameData.companion_data = area.owner.companion_data
	if target_scene == "hub":
		get_tree().call_deferred("change_scene_to_file", "res://Levels/" + target_scene + ".tscn")
	else:
		get_tree().call_deferred("change_scene_to_file", "res://Levels/" + target_scene + "_" + str(GameData.next_room) + ".tscn")
