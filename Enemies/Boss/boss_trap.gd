extends Node2D

var data: EnemyData
var current_health: int = 2 
var is_trap = true

func get_stun_resistance() -> float:
	return 0.0

func _on_area_2d_area_entered(area: Area2D) -> void:
	var direction: Vector2 = (area.global_position - global_position).normalized()
	if area.has_method("take_damage"):
		area.take_damage(1, direction, 0.1)
