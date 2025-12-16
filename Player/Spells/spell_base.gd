class_name SpellBase

var active_time: float
var cooldown: float
var mana_cost: int
var element: String


func cast(player: Player):
	if player.current_mana < mana_cost:
		print("not enough mana")
		return false
	return true
