extends CanvasLayer

var player: Player
@onready var health_label: Label = $MarginContainer/VBoxContainer/HealthLabel
@onready var mana_label: Label = $MarginContainer/VBoxContainer/ManaLabel

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	player.hurtbox.hit_received.connect(_health_changed)
	player.mana_changed.connect(_mana_changed)
	_health_changed(Vector2.ZERO, 0)

func _health_changed(_direction: Vector2, _time: float) -> void:
	health_label.text = "Health: " + str(player.current_health)

func _mana_changed() -> void:
	mana_label.text = "Mana: " + str(player.current_mana)
