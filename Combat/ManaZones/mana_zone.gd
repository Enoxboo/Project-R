extends Area2D

@onready var sprite: Sprite2D = $Sprite
@onready var timer: Timer = $Timer

@export var element: String
@export var active_time: float = 2.0

func _ready() -> void:
	if element == "Fire":
		sprite.modulate = "Red"
	elif element == "Wind":
		sprite.modulate = "Silver"
	timer.wait_time = active_time
	timer.start()


func _on_area_entered(area: Area2D) -> void:
	if Layers.is_on_layer(area.collision_layer, Layers.PLAYER_HURTBOX) or Layers.is_on_layer(area.collision_layer, Layers.ENEMY_HURTBOX):
		match element:
			"Fire":
				area.burn(3, 1)
			"Wind":
				area.get_parent().wind_boost()

func _on_area_exited(area: Area2D) -> void:
	if Layers.is_on_layer(area.collision_layer, Layers.PLAYER_HURTBOX) or Layers.is_on_layer(area.collision_layer, Layers.ENEMY_HURTBOX):
		match element:
			"Wind": area.get_parent().end_wind_boost()
	

func _on_timer_timeout() -> void:
	queue_free()
