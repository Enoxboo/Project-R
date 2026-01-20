class_name ProjectileConfig extends RefCounted

var sprite: Texture2D
var size: Vector2 = Vector2(10.0, 2.0)
var speed: float = 1000.0
var traveling_time: float = 10.0
var is_ally: bool = true
var collision_layer: int = Layers.PLAYER_PROJECTILE
var collision_masks: Array = []
var damage: int = 1
var stun_duration: float = 0.0
var element: String = "None"
var destruct_on_hit: bool = true
