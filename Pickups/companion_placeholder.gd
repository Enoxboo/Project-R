extends Area2D

@export var data: Resource
@onready var companion_preview: Sprite2D = $CompanionPreview

func _ready() -> void:
	companion_preview.texture = data.sprite

func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.has_method("change_companion"):
		body.change_companion(data)
