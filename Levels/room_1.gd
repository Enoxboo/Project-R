extends Node2D

@onready var portal: Area2D = $Portal

var enemies_alive: int


func _ready():
	enemies_alive = get_tree().get_nodes_in_group("Enemy").size()

	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.tree_exited.connect(_on_enemy_died)

	portal.visible = false
	portal.monitoring = false


func _on_enemy_died():
	enemies_alive -= 1
	print("Enemies left: ", enemies_alive)

	if enemies_alive <= 0:
		GameData.next_room += 1
		portal.visible = true
		portal.monitoring = true
		print("All enemies defeated!")
