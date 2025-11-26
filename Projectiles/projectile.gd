extends Node2D

class_name Projectile

@onready var area_2d: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite
@onready var timer: Timer = $Timer
const BASE_PROJECTILE = preload("uid://uponwqt1ncca")
const PROJECTILE = preload("uid://cl3jxyqt80hkg")

const playerhurtbox: int = 4
const playerhitbox: int = 8
const enemyhurtbox: int = 64
const enemyhitbox: int = 128

#Change them in the new instance
var sprite_texture: Texture2D = BASE_PROJECTILE
var is_ally: bool = true
var traveling_time: float = 10.0
var speed: float = 800.0
var damage: int = 1
var stun_duration: float = 1.0

var direction: Vector2 = Vector2(1.0, 0.0)


func _ready() -> void:
	if sprite_texture:
		sprite.texture = sprite_texture
	if not is_ally:
		area_2d.collision_layer = enemyhitbox
		area_2d.collision_mask = playerhurtbox
	else:
		area_2d.collision_layer = playerhitbox
		area_2d.collision_mask = enemyhurtbox
	timer.wait_time = traveling_time
	timer.start()


func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		queue_free()

	position += direction * speed * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(damage, direction, stun_duration)
