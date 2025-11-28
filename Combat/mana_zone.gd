extends Area2D

@onready var sprite: Sprite2D = $Sprite
var element: String

func _ready() -> void:
	if element == "Fire":
		sprite.modulate = "Red"
