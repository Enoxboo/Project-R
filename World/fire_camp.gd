extends Area2D

@onready var spell_selector: CanvasLayer = $SpellSelector
var player: Player


func _ready():
	player = get_tree().get_first_node_in_group("Player")
	if player:
		spell_selector.spell_selected.connect(player._on_spell_selected)


func _on_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("Player") and not spell_selector.is_spell_selected:
		spell_selector.show_menu()
