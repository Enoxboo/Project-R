extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var label: Label = $Tuto/Label
@onready var portal: Area2D = $Portal

func _ready() -> void:
	portal.visible = false
	portal.monitoring = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if Layers.is_on_layer(area.collision_layer, Layers.PLAYER_PROJECTILE):
		label.text = "bravo"
		portal.visible = true
		portal.monitoring = true
		area_2d.visible = false
		area_2d.monitoring = false
