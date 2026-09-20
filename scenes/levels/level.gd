extends Node2D

const LASER_SCENE: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const GRENADE_SCENE: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

@onready var projectiles: Node2D = $Projectiles
@onready var player: CharacterBody2D = $Player
@onready var player_camera: Camera2D = $Player/Camera2D


func _on_gate_player_entered_gate(_body: Node2D) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(player, "speed", 0, 0.5)


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


func _on_house_player_entered() -> void:
	var tween := get_tree().create_tween()
	#tween.set_parallel(true)
	tween.tween_property(player_camera, "zoom", Vector2(1, 1), 1).set_trans(Tween.TRANS_QUAD)
	#tween.tween_property($Player as Node2D, "modulate:a", 0, 2)


func _on_house_player_exited() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(player_camera, "zoom", Vector2(0.6, 0.6), 1).set_trans(Tween.TRANS_QUAD)
