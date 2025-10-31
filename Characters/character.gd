extends CharacterBody2D

class_name Character

@onready var dash_duration_timer: Timer = $DashDurationTimer
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer
@onready var dash_burst: GPUParticles2D = $DashBurst

@export var data: CharacterData

var can_dash = true
var last_direction: Vector2

func _ready() -> void:
	dash_burst.process_material = dash_burst.process_material.duplicate()
	dash_duration_timer.wait_time = data.dash_time
	dash_cooldown_timer.wait_time = data.dash_cooldown

func get_input_direction() -> Vector2:
	return Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()

func start_dash_particles() -> void:
	dash_burst.emitting = true
