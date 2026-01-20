extends State

var attacks = [
	{"name": ATTACK1, "weight": 1.0},
	{"name": ATTACK2, "weight": 1.0},
]

var last_attack = null

func enter(_data := {}) -> void:
	parent.attack_cooldown.start()

func physics_update(_delta: float) -> void:
	if parent.attack_cooldown.is_stopped():
		var next_attack = choose_weighted_attack()
		last_attack = next_attack
		finished.emit(next_attack)

func choose_weighted_attack():
	var available_attacks = attacks.filter(
		func(atk): return atk.name != last_attack
	)
	
	var total_weight = 0.0
	for atk in available_attacks:
		total_weight += atk.weight
	
	var roll = randf() * total_weight
	var cumulative = 0.0
	
	for atk in available_attacks:
		cumulative += atk.weight
		if roll < cumulative:
			return atk.name
	
	return available_attacks[0].name
