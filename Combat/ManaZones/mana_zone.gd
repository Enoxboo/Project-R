extends Area2D

@onready var sprite: Sprite2D = $Sprite
@onready var timer: Timer = $Timer

@export var element: String
@export var active_time: float = 2.0

func _ready() -> void:
	if element == "Fire":
		sprite.modulate = "Red"
	elif element == "WInd":
		sprite.modulate = "Gray"
	timer.wait_time = active_time
	timer.start()


func _on_area_entered(area: Area2D) -> void:
	if element == "Fire" and Layers.is_on_layer(area.collision_layer, Layers.PLAYER_HURTBOX) or Layers.is_on_layer(area.collision_layer, Layers.ENEMY_HURTBOX):
		area.burn(3, 1)


func _on_timer_timeout() -> void:
	queue_free()
