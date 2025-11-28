extends Node2D

class_name Projectile

@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape
@onready var area_2d: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite
@onready var timer: Timer = $Timer
const BASE_PROJECTILE = preload("uid://uponwqt1ncca")
const PROJECTILE = preload("uid://cl3jxyqt80hkg")

const PLAYER_HURTBOX = 4
const PLAYER_PROJECTILE = 256
const ENEMY_HURTBOX = 64
const ENEMY_PROJECTILE = 4096
const SPELL_UTILITY = 2048

#Change them in the new instance
var sprite_texture: Texture2D = BASE_PROJECTILE
var is_ally: bool = true
var traveling_time: float = 10.0
var speed: float = 800.0
var damage: int = 1
var stun_duration: float = 1.0
var is_attack = true

var direction: Vector2 = Vector2(1.0, 0.0)

func set_collision_size(new_size: Vector2) -> void:
	collision_shape.shape.size = new_size


func _ready() -> void:
	if sprite_texture:
		sprite.texture = sprite_texture
	if not is_ally and is_attack:
		area_2d.collision_layer = ENEMY_PROJECTILE
		area_2d.collision_mask = PLAYER_HURTBOX
	elif is_ally and is_attack:
		area_2d.collision_layer = PLAYER_PROJECTILE
		area_2d.collision_mask = ENEMY_HURTBOX
	elif not is_ally and not is_attack:
		area_2d.collision_layer = SPELL_UTILITY
		area_2d.collision_mask = PLAYER_PROJECTILE
	else:
		area_2d.collision_layer = SPELL_UTILITY
		area_2d.collision_mask = ENEMY_PROJECTILE
	
	timer.wait_time = traveling_time
	timer.start()


func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		queue_free()
		

	position += direction * speed * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage") and is_attack:
		area.take_damage(damage, direction, stun_duration)
	queue_free()

func apply_spell():
	pass
