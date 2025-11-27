extends Area2D

class_name Spell

@onready var timer: Timer = $Timer

var active_time: float = 3.0
var speed: float = 200.0
var mana_cost: int = 5

func _ready() -> void:
	timer.wait_time = active_time
	timer.start()

func _physics_process(_delta: float) -> void:
	if timer.is_stopped():
		queue_free()

func cast(player: Player) -> bool:
	if player.current_mana < mana_cost:
		print("not enough mana")
		return false
	return true
