extends CharacterBody2D

class_name Enemy

@onready var sprite: Sprite2D = $Sprite
@onready var hurtbox: Area2D = $Hurtbox
@export var data: EnemyData
@onready var knockback_timer: Timer = $Timers/KnockbackTimer
@onready var stun_timer: Timer = $Timers/StunTimer
@onready var attack_cooldown: Timer = $Timers/AttackCooldown
@onready var wind_boost_decay: Timer = $Timers/WindBoostDecay
@onready var burn_damage_timer: Timer = $Timers/BurnDamageTimer

var player: Player
var current_health: int
var can_attack = true
var is_wind_boost = false
var speed_modifier: float = 1.0
var base_speed_modifier: float = 1.0
var wind_power: float = -0.5


func _ready() -> void:
	current_health = data.max_health
	sprite.texture = data.sprite
	player = get_tree().get_first_node_in_group("Player")


func _on_hitbox_area_entered(area: Area2D) -> void:
	var direction: Vector2 = (area.global_position - global_position).normalized()
	HitboxUtil.hurt_target(area, data.damage, direction, data.stun_duration)


func start_burning() -> void:
	burn()
	burn_damage_timer.start()


func end_burning() -> void:
	burn_damage_timer.stop()


func _on_attack_cooldown_timeout() -> void:
	can_attack = true


func wind_boost() -> void:
	if is_wind_boost:
		return

	is_wind_boost = true
	speed_modifier = wind_power


func end_wind_boost() -> void:
	if not wind_boost_decay.is_stopped():
		wind_boost_decay.stop()
	wind_boost_decay.start()


func _on_wind_boost_decay_timeout() -> void:
	is_wind_boost = false
	speed_modifier = base_speed_modifier


func get_stun_resistance() -> float:
	return data.stun_resistance


func _on_burn_damage_timer_timeout() -> void:
	burn()

func burn() -> void:
	sprite.modulate = "RED"
	current_health = max(0, current_health - 1)
	hurtbox.emit_signal("health_changed", current_health)
	await get_tree().create_timer(0.3).timeout
	sprite.modulate = "WHITE"
	await get_tree().create_timer(0.7).timeout
