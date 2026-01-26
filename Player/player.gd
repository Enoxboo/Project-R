extends CharacterBody2D

class_name Player

signal mana_changed

const MAIN_DATA = preload("uid://dsefs1fellje")
const MainMoveset = preload("uid://dhssc3mpye67i")

@onready var sprite: Sprite2D = $Sprite
@onready var hitbox: Area2D = $Hitbox
@onready var hitbox_sprite: Sprite2D = $Hitbox/HitboxSprite
@onready var hurtbox: Area2D = $Hurtbox
@onready var knockback_timer: Timer = $Timers/KnockbackTimer
@onready var stun_timer: Timer = $Timers/StunTimer
@onready var spell_1_cooldown: Timer = $Timers/Spell1Cooldown
@onready var spell_2_cooldown: Timer = $Timers/Spell2Cooldown
@onready var switch_timer: Timer = $Timers/SwitchTimer
@onready var dash_cooldown: Timer = $Timers/DashCooldown
@onready var wind_boost_decay: Timer = $Timers/WindBoostDecay
@onready var burn_damage_timer: Timer = $Timers/BurnDamageTimer

var data: PlayerData = MAIN_DATA
var moveset_instance = MainMoveset.new()
var current_health: int
var is_main_active = true
var can_attack = true
var can_spell_1 = true
var can_spell_2 = true
var can_dash = true
var can_switch = true
var is_wind_boost = false
var companion_data: Resource = null
var spell1_instance
var spell2_instance
var current_mana: float
var speed_modifier: float = 1.0
var base_speed_modifier: float = 1.0
var wind_power: float = 2.0


func _ready() -> void:
	current_health = GameData.player_health
	current_mana = GameData.player_mana
	spell1_instance = GameData.equipped_spell_1
	spell2_instance = GameData.equipped_spell_2
	companion_data = GameData.companion_data


func _process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		moveset_instance.attack(self)
	elif event.is_action_pressed("spell_1"):
		moveset_instance.spell_1(self)
	elif event.is_action_pressed("spell_2"):
		moveset_instance.spell_2(self)


func change_companion(new_companion: Resource) -> void:
	companion_data = new_companion


func _on_spell_selected(spell_name: String):
	if not spell1_instance:
		spell1_instance = SpellManager.SPELLS[spell_name].new()
		spell_1_cooldown.wait_time = spell1_instance.cooldown
	elif not spell2_instance:
		spell2_instance = SpellManager.SPELLS[spell_name].new()
		spell_2_cooldown.wait_time = spell2_instance.cooldown
	else:
		print("No more spell slot")


func _on_hitbox_area_entered(area: Area2D) -> void:
	var direction: Vector2 = (area.global_position - global_position).normalized()
	HitboxUtil.hurt_target(area, data.damage, direction, data.stun_duration)


func _on_spell_1_cooldown_timeout() -> void:
	can_spell_1 = true


func _on_spell_2_cooldown_timeout() -> void:
	can_spell_2 = true


func _on_switch_timer_timeout() -> void:
	can_switch = true


func _on_dash_cooldown_timeout() -> void:
	can_dash = true


func _on_mana_changed() -> void:
	emit_signal("mana_changed")


func start_burning() -> void:
	burn()
	burn_damage_timer.start()


func end_burning() -> void:
	burn_damage_timer.stop()


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
