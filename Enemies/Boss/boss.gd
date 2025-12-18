extends CharacterBody2D

@onready var attack_cooldown: Timer = $AttackCooldown
@onready var hurtbox: Area2D = $Hurtbox
@onready var sprite: Sprite2D = $Sprite2D

@export var data: EnemyData
var current_health: int

func _ready() -> void:
	current_health = data.max_health
