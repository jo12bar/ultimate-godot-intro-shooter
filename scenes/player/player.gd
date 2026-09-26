class_name Player
extends CharacterBody2D

## Emitted whenever the player fires a laser. [param spawn_pos] is the starting
## position for the laser in global coordinates. [param direction] is the
## direction that the laser is being fired in.
signal laser_fired(spawn_pos: Vector2, direction: Vector2)
## Emitted whenever the player fires a grenade. [param spawn_pos] is the starting
## position for the grenade in global coordinates. [param direction] is the
## direction that the grenade is being fired in.
signal grenade_fired(spawn_pos: Vector2, direction: Vector2)

signal update_stats

@export var max_speed: float = 500
var speed: float = max_speed

var can_laser: bool = true
var can_grenade: bool = true

@onready var laser_reload_timer: Timer = $LaserReloadTimer
@onready var laser_start_positions: Node2D = $LaserStartPositions
@onready var laser_particles: GPUParticles2D = $LaserParticles
@onready var grenade_reload_timer: Timer = $GrenadeReloadTimer
@onready var grenade_start_positions: Node2D = $GrenadeStartPositions


func _process(_delta: float) -> void:
	# Laser shooting input
	if (
		Input.is_action_pressed("primary_action")
		and can_laser
		and Globals.laser_amount > 0
	):
		# Decrease laser ammo
		Globals.laser_amount -= 1
		
		# Start laser cooldown timer
		can_laser = false
		laser_reload_timer.start()
		
		# Randomly select a laser start position
		var laser_markers := laser_start_positions.get_children()
		var selected_marker: Node2D = laser_markers[randi() % laser_markers.size()]
		
		# Figure out which way to fire the laser
		var player_direction = global_transform.x
		
		# Emit laser fired signal with the position we selected
		laser_fired.emit(selected_marker.global_position, player_direction)
		
		# Fire particles
		laser_particles.restart()
	
	# Grenade shooting input
	if (
		Input.is_action_pressed("secondary_action")
		and can_grenade
		and Globals.grenade_amount > 0
	):
		# Decrease grenade ammo
		Globals.grenade_amount -= 1
		
		# Start grenade cooldown timer
		can_grenade = false
		grenade_reload_timer.start()
		
		# Randomly select a grenade start position
		var grenade_markers := grenade_start_positions.get_children()
		var selected_marker: Node2D = grenade_markers[randi() % grenade_markers.size()]
		
		# Figure out which way to fire the grenade
		var player_direction = global_transform.x
		
		# Emit grenade fired signal with the position we selected
		grenade_fired.emit(selected_marker.global_position, player_direction)


func _physics_process(_delta: float) -> void:
	# Movement
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	
	# Rotation
	look_at(get_global_mouse_position())
	
	move_and_slide()


func _on_laser_reload_timer_timeout() -> void:
	can_laser = true


func _on_grenade_reload_timer_timeout() -> void:
	can_grenade = true


func add_item(type: Item.ItemType) -> void:
	if type == Item.ItemType.LASER:
		Globals.laser_amount += 5
		update_stats.emit()
	elif type == Item.ItemType.GRENADE:
		Globals.grenade_amount += 1
		update_stats.emit()
