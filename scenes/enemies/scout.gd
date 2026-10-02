extends CharacterBody2D

## Emitted whenever the enemy fires a laser. [param spawn_pos] is the starting
## position for the laser in global coordinates. [param direction] is the
## direction that the laser is being fired in.
signal laser_fired(spawn_pos: Vector2, direction: Vector2)

var health: int = 30

var player_nearby: bool = false
var can_get_hit: bool = true
var can_laser: bool = true

@onready var hit_invulnerability_timer: Timer = $Timers/HitInvulnerabilityTimer
@onready var laser_cooldown_timer: Timer = $Timers/LaserCooldownTimer
@onready var laser_spawn_positions: Node2D = $LaserSpawnPositions

var _cur_laser_spawn_pos_idx: int = 0


func hit() -> void:
	if can_get_hit:
		health -= 10
		if health <= 0:
			queue_free()
		else:
			can_get_hit = false
			hit_invulnerability_timer.start()


func _process(_delta: float) -> void:
	if player_nearby and can_laser:
		var laser_spawn_pos := _get_laser_spawn_pos().global_position
		var laser_spawn_dir := (Globals.player_position - laser_spawn_pos).normalized()
		
		laser_fired.emit(laser_spawn_pos, laser_spawn_dir)
		can_laser = false
		
		laser_cooldown_timer.start()


func _physics_process(_delta: float) -> void:
	if player_nearby:
		look_at(Globals.player_position)


func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false


func _get_laser_spawn_pos() -> Marker2D:
	var num_possible_positions = laser_spawn_positions.get_child_count()
	_cur_laser_spawn_pos_idx += 1
	if _cur_laser_spawn_pos_idx >= num_possible_positions:
		_cur_laser_spawn_pos_idx = 0
	return laser_spawn_positions.get_child(_cur_laser_spawn_pos_idx)
pass # Replace with function body.


func _on_laser_cooldown_timer_timeout() -> void:
	can_laser = true


func _on_hit_invulnerability_timer_timeout() -> void:
	can_get_hit = true
