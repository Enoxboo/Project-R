extends Moveset

const ARROW = preload("uid://uponwqt1ncca")
var arrow_config: ProjectileConfig


func _ready():
	arrow_config = ProjectileConfig.new()
	arrow_config.sprite = ARROW
	arrow_config.size = Vector2(10.0, 2.0)
	arrow_config.speed = 1000.0
	arrow_config.traveling_time = 10.0
	arrow_config.is_ally = true
	arrow_config.collision_layer = Layers.PLAYER_PROJECTILE
	arrow_config.collision_masks = [
		Layers.ENEMY_HURTBOX,
		Layers.MANA_ZONE,
		Layers.PLAYER_SPELL_OFFENSIVE,
		Layers.PLAYER_SPELL_UTILITY,
		Layers.WALLS,
	]
	arrow_config.damage = 1
	arrow_config.stun_duration = 1.0
	arrow_config.element = "None"
	arrow_config.destruct_on_hit = true


func _perform_attack(player: Player) -> void:
	ProjectileHelper.throw(player, arrow_config)


func _end_attack(_player: Player) -> void:
	print("fin")
