extends Resource

class_name PlayerData



@export var sprite: Texture2D
@export var max_health: int = 10
@export var max_mana: int = 100
@export var speed: float = 300.0
@export var dash_force: float = 700.0
@export var dash_time: float = 0.2
@export var moveset: GDScript
@export var initial_state: String = "Move"
@export var damage: int = 1
@export var attack_active: float = 0.3
@export var attack_rest: float = 0.5
@export var attack_offset: float = 40.0
@export var stun_duration: float = 0.7
@export var stun_resistance: float = 0.0
@export var knockback_force: float = 100.0
@export var knockback_time: float = 0.1
