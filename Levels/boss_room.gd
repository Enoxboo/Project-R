extends Node2D

const BOSS_TRAP = preload("uid://3khqdsdhdsye")
@onready var room_trap_spawn_1: Node2D = $RoomTrapSpawn1
@onready var room_trap_spawn_2: Node2D = $RoomTrapSpawn2

var is_active = false

func _process(_delta: float) -> void:
	if is_active:
		return
	
	is_active = true
	var trap1 = BOSS_TRAP.instantiate()
	var trap2 = BOSS_TRAP.instantiate()
	trap1.global_position = room_trap_spawn_1.global_position
	trap2.global_position = room_trap_spawn_2.global_position
	add_child(trap1)
	add_child(trap2)
	await get_tree().create_timer(1.0).timeout
	
