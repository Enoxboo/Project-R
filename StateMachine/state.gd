extends Node

class_name State

@warning_ignore("unused_signal")
signal finished(next_state_path: String, data: Dictionary)

const MOVE = "Move"
const SWITCH = "Switch"

const CHASE = "Chase"

var parent: CharacterBody2D


func _ready() -> void:
	await owner.ready
	parent = owner as CharacterBody2D


func physics_update(_delta: float) -> void:
	pass


func enter(_data := { }) -> void:
	pass


func exit() -> void:
	pass
