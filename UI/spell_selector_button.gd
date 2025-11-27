extends Control

var player: Player

@export_enum("fireball") var spell_name: String

const SPELLS = {
	"fireball": preload("uid://bcceopqyc7p3h"),
}


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")


func _on_button_spell_1_button_down() -> void:
	player.spell1_instance = SPELLS[spell_name].new()
	player.spell_1_cooldown.wait_time = player.spell1_instance.cooldown
