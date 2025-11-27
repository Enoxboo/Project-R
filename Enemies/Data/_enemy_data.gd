extends Resource

class_name EnemyData

const ally: bool = false

@export var sprite: Texture2D
@export var speed: float = 100.0
@export var damage: int = 1
@export var stun_duration: float = 1
@export var stun_resistance: float = 0.0
@export var initial_state: String = ""
@export var attack_sprite: Texture2D
@export var attack_range: float = 200.0
@export var attack_size: Vector2 = Vector2(10.0, 2.0)
@export var projectile_speed: float = 1000.0
@export var projectile_time: float = 10.0
@export var projectile_stun: float = 1.0
