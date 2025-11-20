extends Area2D

@export var data: Resource

func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.has_method("change_companion"):
		body.change_companion(data)
