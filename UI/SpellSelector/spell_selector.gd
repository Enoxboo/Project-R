extends CanvasLayer

signal spell_selected(spell_name: String)

@onready var fireball_btn: Button = $Panel/MarginContainer/VBoxContainer/FireballBtn
@onready var windwall_btn: Button = $Panel/MarginContainer/VBoxContainer/WindwallBtn

var is_spell_selected = false


func _ready():
	fireball_btn.pressed.connect(_on_fireball_selected)
	windwall_btn.pressed.connect(_on_windwall_selected)
	visible = false


func show_menu():
	visible = true


func _on_fireball_selected():
	spell_selected.emit("fireball")
	visible = false
	is_spell_selected = true


func _on_windwall_selected():
	spell_selected.emit("windwall")
	visible = false
	is_spell_selected = true
