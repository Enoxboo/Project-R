extends Area2D

@onready var timer: Timer = $Timer

var active_time: float = 3.0

func _ready() -> void:
	timer.wait_time = active_time
	timer.start()

func _physics_process(_delta: float) -> void:
	if timer.is_stopped():
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	area.get_parent().sprite.modulate = "RED"
