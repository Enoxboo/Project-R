extends CharacterBody2D

class_name Player

const MAIN_DATA = preload("uid://dsefs1fellje")

@onready var sprite: Sprite2D = $Sprite
@onready var hitbox: Area2D = $Hitbox
@onready var hitbox_sprite: Sprite2D = $Hitbox/HitboxSprite
@onready var hurtbox: Area2D = $Hurtbox
@onready var attack_active: Timer = $Timers/AttackActive
@onready var attack_rest: Timer = $Timers/AttackRest
@onready var knockback_timer: Timer = $Timers/KnockbackTimer
@onready var stun_timer: Timer = $Timers/StunTimer

var data: PlayerData = MAIN_DATA
var moveset_instance: Moveset = data.moveset.new()
var current_health: int
var is_main_active = true
var can_attack = true
var can_spell_1 = true
var can_spell_2 = true
var companion_data: Resource = null
var spell1_instance
var current_mana: float

func _ready() -> void:
	current_health = data.max_health
	current_mana = data.max_mana
	print(current_health)


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
	print(companion_data)


func _on_hitbox_area_entered(area: Area2D) -> void:
	var direction: Vector2 = (area.global_position - global_position).normalized()
	if area.has_method("take_damage"):
		area.take_damage(data.damage, direction, data.stun_duration)
