extends CharacterBody2D

class_name Enemy

@onready var sprite: Sprite2D = $Sprite
@export var data: EnemyData

var player: Player

func _ready() -> void:
	sprite.texture = data.sprite
	player = get_tree().get_first_node_in_group("Player")
