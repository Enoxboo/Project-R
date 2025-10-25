class_name CharacterState
extends State

const MOVE = "Move"

var character: Character


func _ready() -> void:
	await owner.ready
	character = owner as Character
	assert(character != null)
