extends CharacterBody2D

class_name Enemy

@onready var sprite: Sprite2D = $Sprite
@onready var hurtbox: Area2D = $Hurtbox
@export var data: EnemyData
@onready var knockback_timer: Timer = $Timers/KnockbackTimer
@onready var stun_timer: Timer = $Timers/StunTimer
@onready var attack_cooldown: Timer = $Timers/AttackCooldown
@onready var wind_boost_decay: Timer = $Timers/WindBoostDecay

var player: Player
var max_health: int = 10
var current_health: int
var can_attack = true
var is_wind_boost = false

func _ready() -> void:
	current_health = max_health
	sprite.texture = data.sprite
	player = get_tree().get_first_node_in_group("Player")


func _on_hitbox_area_entered(area: Area2D) -> void:
	var direction: Vector2 = (area.global_position - global_position).normalized()
	if area.has_method("take_damage"):
		area.take_damage(data.damage, direction, data.stun_duration)


func _on_attack_cooldown_timeout() -> void:
	can_attack = true

func wind_boost() -> void:
	if not is_wind_boost:
		is_wind_boost = true
		data.speed *= 2

func end_wind_boost() -> void:
	if not wind_boost_decay.is_stopped():
		wind_boost_decay.stop()
	wind_boost_decay.start()
	

func _on_wind_boost_decay_timeout() -> void:
	is_wind_boost = false
	data.speed /= 2
	print(data.speed)
