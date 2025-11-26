extends Area2D

class_name Spell

@onready var timer: Timer = $Timer

var active_time: float = 3.0
var speed: float = 200.0

func _ready() -> void:
	timer.wait_time = active_time
	timer.start()

func _physics_process(_delta: float) -> void:
	if timer.is_stopped():
		queue_free()

func cast(player: Player) -> void:
	print("magie de " + str(player))
