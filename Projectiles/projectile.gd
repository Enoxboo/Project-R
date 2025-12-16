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
var element: String
var direction: Vector2 = Vector2(1.0, 0.0)
var destruct_on_hit = true


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
	HitboxUtil.hurt_target(area, damage, direction, stun_duration)
	ElementUtil.apply_element(area, element)
	ComboManager.process_magic_interaction(area, self)

	var is_magic_collision = Layers.is_magical(area.collision_layer)
	HitboxUtil.spawn_zone(self, is_magic_collision)
