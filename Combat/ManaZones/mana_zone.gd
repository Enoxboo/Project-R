extends Area2D

class_name ManaZone

@onready var sprite: Sprite2D = $Sprite
@onready var timer: Timer = $Timer

@export var element: String
@export var active_time: float = 2.0

func _ready() -> void:
	if element == "Fire":
		sprite.modulate = "Red"
	elif element == "Wind":
		sprite.modulate = "Silver"
	timer.wait_time = active_time
	timer.start()


func _on_area_entered(area: Area2D) -> void:
	ElementUtil.apply_element(area, element)


func _on_area_exited(area: Area2D) -> void:
	ElementUtil.end_element(area, element)


func _on_timer_timeout() -> void:
	queue_free()
