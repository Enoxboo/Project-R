extends CanvasLayer

@onready var health_bar: ProgressBar = $HealthBar

var boss: Area2D

func _ready() -> void:
	boss = get_tree().get_first_node_in_group("Boss")
	if boss:
		health_bar.max_value = boss.data.max_health
		health_bar.value = boss.data.max_health
		boss.hurtbox.health_changed.connect(_on_health_changed)
		_on_health_changed(GameData.player_health)


func _on_health_changed(new_health: int) -> void:
	health_bar.value = new_health
