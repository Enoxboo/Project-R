extends Node2D

const BOSS_TRAP = preload("uid://3khqdsdhdsye")

var spawn_points = [
	{
		"position": Vector2(-435, -520),
		"rotation": deg_to_rad(-20)
	},
	{
		"position": Vector2(435, -520),
		"rotation": deg_to_rad(20)
	}
]

var trap_left: int = 0
var is_boss_alive = true
var can_spawn: bool = true

func _ready():
	_spawn_traps()

func _spawn_traps():
	if not is_boss_alive or not can_spawn:
		return
	
	can_spawn = false
	trap_left = 2
	
	await get_tree().create_timer(2.0).timeout
	
	for i in range(2):
		_create_trap()

func _create_trap():
	var spawn_data = spawn_points[randi() % spawn_points.size()]
	
	var trap = BOSS_TRAP.instantiate()
	trap.global_position = spawn_data.position
	trap.rotation = spawn_data.rotation
	add_child(trap)
	trap.tree_exiting.connect(_on_trap_destroyed)

func _on_trap_destroyed():
	trap_left -= 1
	
	if trap_left == 0:
		can_spawn = true
		_spawn_traps()
