# res://Utils/AutoLoad/layers.gd
extends Node

# Player
const PLAYER_BODY = 1
const PLAYER_HURTBOX = 2
const PLAYER_HITBOX = 3
const PLAYER_PROJECTILE = 4
const PLAYER_SPELL_OFFENSIVE = 5
const PLAYER_SPELL_UTILITY = 6

# Enemy
const ENEMY_BODY = 7
const ENEMY_HURTBOX = 8
const ENEMY_HITBOX = 9
const ENEMY_PROJECTILE = 10

# Universal
const MANA_ZONE = 11

# World
const WALLS = 12
const INTERACTABLES = 13


func is_on_layer(collision_layer: int, layer: int) -> bool:
	return collision_layer & (1 << layer - 1) != 0


func get_layer_mask(layer: int) -> int:
	return 1 << (layer - 1)
