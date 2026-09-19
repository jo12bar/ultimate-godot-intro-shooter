extends Node2D

const LASER_SCENE: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const GRENADE_SCENE: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

@onready var projectiles: Node2D = $Projectiles


func _on_gate_player_entered_gate(body: Node2D) -> void:
	print("player %s has entered gate" % body)


func _on_player_laser_fired(spawn_pos: Vector2, direction: Vector2) -> void:
	var laser: Node2D = LASER_SCENE.instantiate()
	
	# set laser position so it comes from the player's gun
	laser.position = spawn_pos
	laser.rotation = direction.angle() + PI/2.0
	laser.direction = direction

	# add the laser instance to a Node2D
	projectiles.add_child(laser)


func _on_player_grenade_fired(spawn_pos: Vector2, direction: Vector2) -> void:
	var grenade: RigidBody2D = GRENADE_SCENE.instantiate()
	
	# set grenade position so it comes from the player's gun
	grenade.position = spawn_pos
	grenade.linear_velocity = direction * grenade.speed
	
	# add the grenade instance to a Node2D
	projectiles.add_child(grenade)
