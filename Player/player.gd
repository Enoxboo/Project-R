extends CharacterBody2D

class_name Player

const MAIN_DATA = preload("uid://dsefs1fellje")
const ELEANOR_DATA = preload("uid://davvempunmoqd")

@onready var sprite: Sprite2D = $Sprite
@onready var hitbox: Area2D = $Hitbox
@onready var hitbox_sprite: Sprite2D = $Hitbox/HitboxSprite
@onready var attack_active: Timer = $Timers/AttackActive
@onready var attack_rest: Timer = $Timers/AttackRest

var data: PlayerData = MAIN_DATA
var moveset_instance: Moveset = data.moveset.new()
var is_main_active = true
var can_attack = true
var can_spell_1 = true
var can_spell_2 = true


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
