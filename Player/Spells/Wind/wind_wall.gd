extends Spell

const WIND = preload("uid://c2vcprt14i77g")


func _init() -> void:
	speed = 50.0
	active_time = 10.0
	damage = 0
	stun_time = 0
	size = Vector2(6.0, 30.0)


func _ready() -> void:
	speed = 50.0
	active_time = 10.0
	damage = 0
	stun_time = 0
	size = Vector2(6.0, 30.0)
	super._ready()


func _on_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("Projectile"):
		area.owner.queue_free()


func cast(player) -> bool:
	if not super.cast(player):
		return false

	player.current_mana -= mana_cost
	emit_signal("mana_changed")

	var proj = ProjectileHelper.throw(player, WIND, size, speed, active_time, ally, damage, stun_time, false, "Wind")
	proj.area_2d.area_entered.connect(_on_area_entered)

	return true
