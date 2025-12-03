extends Area2D

@export var data: Resource
@onready var companion_preview: Sprite2D = $CompanionPreview


func _ready() -> void:
	companion_preview.texture = data.sprite


func _on_area_entered(area: Area2D) -> void:
	if area.owner.has_method("change_companion"):
		area.owner.change_companion(data)
