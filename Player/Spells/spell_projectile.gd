extends SpellBase

class_name SpellProjectile

var sprite: Texture2D
var speed: float
var damage: int
var stun_time: float
var size: Vector2
var masks: Array
var destruct_on_hit: bool


func cast(player):
	if not super.cast(player):
		return

	player.current_mana -= mana_cost
	player.emit_signal("mana_changed")

	var proj = ProjectileHelper.throw(player, sprite, size, speed, active_time, true, Layers.PLAYER_SPELL_OFFENSIVE, masks, damage, stun_time, element, destruct_on_hit) # ← Récupère le projectile
	return proj
