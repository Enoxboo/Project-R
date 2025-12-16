extends "res://Levels/room_1.gd"

@onready var label: Label = $Tuto/Label


func _ready() -> void:
	super._ready()
	label.visible = false


func _on_enemy_died():
	super._on_enemy_died()
	if enemies_alive <= 0:
		label.visible = true
