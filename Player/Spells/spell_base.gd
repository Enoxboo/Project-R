extends Area2D

class_name Spell


@onready var timer: Timer = $Timer

var speed: float = 500.0
var active_time: float = 1.0
var ally: bool = true
var damage: int = 1
var stun_time: float = 0.2
var cooldown: float = 3.0
var size: Vector2 = Vector2(10.0, 14.0)
var mana_cost: int = 5
var masks = []


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
