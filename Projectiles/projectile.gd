extends Node2D

class_name Projectile

@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape
@onready var area_2d: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite
@onready var timer: Timer = $Timer
const BASE_PROJECTILE = preload("uid://uponwqt1ncca")
const PROJECTILE = preload("uid://cl3jxyqt80hkg")

#Change them in the new instance
var sprite_texture: Texture2D = BASE_PROJECTILE
var is_ally: bool = true
var traveling_time: float = 10.0
var speed: float = 800.0
var damage: int = 1
var stun_duration: float = 1.0
var is_attack = true
var element: String
var direction: Vector2 = Vector2(1.0, 0.0)


func set_collision_size(new_size: Vector2) -> void:
	collision_shape.shape.size = new_size


func _ready() -> void:
	if sprite_texture:
		sprite.texture = sprite_texture

	timer.wait_time = traveling_time
	timer.start()


func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		queue_free()

	position += direction * speed * delta


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage") and is_attack:
		area.take_damage(damage, direction, stun_duration)


func apply_spell():
	pass
