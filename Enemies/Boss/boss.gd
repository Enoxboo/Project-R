extends CharacterBody2D

@onready var attack_cooldown: Timer = $AttackCooldown
@onready var hurtbox: Area2D = $Hurtbox
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var hitbox_attack_1: Area2D = $HitboxAttack1
@onready var attack_1_sprite: Sprite2D = $HitboxAttack1/Attack1Sprite
@onready var warning_particles: GPUParticles2D = $HitboxAttack1/WarningParticles
@onready var impact_particles: CPUParticles2D = $HitboxAttack1/ImpactParticles

@export var data: EnemyData
var current_health: int
var player: Player

func _ready() -> void:
	current_health = data.max_health
	player = get_tree().get_first_node_in_group("Player")
	hitbox_attack_1.visible = false
	hitbox_attack_1.monitoring = false
	attack_1_sprite.scale = Vector2(0.01, 0.01)



func _on_hitbox_attack_1_area_entered(area: Area2D) -> void:
	var direction: Vector2 = (area.global_position - global_position).normalized()
	if area.has_method("take_damage"):
		area.take_damage(data.damage, direction, data.stun_duration)
