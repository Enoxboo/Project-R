extends Spell

var rotation_speed: float = 100.0
var direction: Vector2


func _ready() -> void:
	speed = 300.0


func _physics_process(delta: float) -> void:
	rotate(rotation_speed * delta)
	position += direction * speed * delta


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("burn"):
		area.burn(3, 2)
