extends Area2D

@onready var sprite: Sprite2D = $Sprite

var element: String

func _ready() -> void:
	if element == "Fire":
		sprite.modulate = "Red"


func _on_area_entered(area: Area2D) -> void:
	area.burn(3, 1)


func _on_timer_timeout() -> void:
	queue_free()
