extends Node2D

var data: EnemyData
var current_health: int = 2 
var is_trap = true

var is_moving: bool = true
var move_speed: float = 400.0
var target_y: float = -176.0
var move_direction: Vector2 = Vector2.ZERO

func _ready():
	move_direction = Vector2.DOWN.rotated(rotation)

func _process(delta: float) -> void:
	if is_moving:
		global_position += move_direction * move_speed * delta
		
		if global_position.y >= target_y:
			is_moving = false
			global_position.y = target_y

func get_stun_resistance() -> float:
	return 0.0

func _on_area_2d_area_entered(area: Area2D) -> void:
	var direction: Vector2 = (area.global_position - global_position).normalized()
	if area.has_method("take_damage"):
		area.take_damage(1, direction, 0.1)
