extends Node

## Emitted whenever the player's laser count changes. [param old_amount] is the
## old laser count, equal to the old value of [member Globals.laser_amount]
## before the change. [param new_amount] is the new value of
## [member Globals.laser_amount], and will always be equal to
## [member Globals.laser_amount] when this signal is emitted.
signal laser_amount_changed(old_amount: int, new_amount: int)
## Emitted whenever the player's grenade count changes. [param old_amount] is
## the old grenade count, equal to the old value of
## [member Globals.grenade_amount] before the change. [param new_amount] is the
## new value of [member Globals.grenade_amount], and will always be equal to
## [member Globals.grenade_amount] when this signal is emitted.
signal grenade_amount_changed(old_amount: int, new_amount: int)
## Emitted whenever the player's health changes. [param old_health] is the old
## health value, equal to the old value of [member Globals.health] before the
## change. [param new_health] is the new value of [member Globals.health], and
## will always be equal to [member Globals.health] when this signal is emitted.
signal health_changed(old_health: int, new_health: int)

var laser_amount: int = 20:
	get:
		return laser_amount
	set(value):
		var old_amount := laser_amount
		laser_amount = value
		laser_amount_changed.emit(old_amount, laser_amount)

var grenade_amount: int = 5:
	get:
		return grenade_amount
	set(value):
		var old_amount := grenade_amount
		grenade_amount = value
		grenade_amount_changed.emit(old_amount, grenade_amount)

var health: int = 60:
	get:
		return health
	set(value):
		var old_health := health
		health = value
		health_changed.emit(old_health, health)

var player_position: Vector2
