extends CharacterBody2D

class_name Enemy

@onready var sprite: Sprite2D = $Sprite
@export var data: EnemyData

var player: Player
var damage: int = 1
var max_health: int = 10
var current_health: int

func _ready() -> void:
	current_health = max_health
	sprite.texture = data.sprite
	player = get_tree().get_first_node_in_group("Player")


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(damage)
