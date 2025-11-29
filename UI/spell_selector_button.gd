extends Control

var player: Player
@onready var button_spell_1: Button = $ButtonSpell1
@onready var button_spell_2: Button = $ButtonSpell2

@export_enum("fireball", "windwall") var spell_1_name: String
@export_enum("fireball", "windwall") var spell_2_name: String

const SPELLS = {
	"fireball": preload("uid://bcceopqyc7p3h"),
	"windwall": preload("uid://bmti8dy6ag2yj"),
}


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	button_spell_1.text = spell_1_name
	button_spell_2.text = spell_2_name

func _on_button_spell_1_button_down() -> void:
	player.spell1_instance = SPELLS[spell_1_name].new()
	player.spell_1_cooldown.wait_time = player.spell1_instance.cooldown


func _on_button_spell_2_button_down() -> void:
	player.spell2_instance = SPELLS[spell_2_name].new()
	player.spell_2_cooldown.wait_time = player.spell2_instance.cooldown
