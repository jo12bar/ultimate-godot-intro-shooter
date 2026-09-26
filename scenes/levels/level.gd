class_name LevelParent
extends Node2D

const LASER_SCENE: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const GRENADE_SCENE: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

@onready var projectiles: Node2D = $Projectiles
@onready var player: CharacterBody2D = $Player
@onready var player_camera: Camera2D = $Player/Camera2D
@onready var ui: Ui = $UI


func _on_player_laser_fired(spawn_pos: Vector2, direction: Vector2) -> void:
	var laser: Node2D = LASER_SCENE.instantiate()
	
	# set laser position so it comes from the player's gun
	laser.position = spawn_pos
	laser.rotation = direction.angle() + PI/2.0
	laser.direction = direction

	# add the laser instance to a Node2D
	projectiles.add_child(laser)
	
	# update ammo count on screen
	ui.update_laser_count_display()


func _on_player_grenade_fired(spawn_pos: Vector2, direction: Vector2) -> void:
	var grenade: RigidBody2D = GRENADE_SCENE.instantiate()
	
	# set grenade position so it comes from the player's gun
	grenade.position = spawn_pos
	grenade.linear_velocity = direction * grenade.speed
	
	# add the grenade instance to a Node2D
	projectiles.add_child(grenade)
	
	# update ammo count on screen
	ui.update_grenade_count_display()


func _on_house_player_entered() -> void:
	var tween := get_tree().create_tween()
	#tween.set_parallel(true)
	tween.tween_property(player_camera, "zoom", Vector2(1, 1), 1).set_trans(Tween.TRANS_QUAD)
	#tween.tween_property($Player as Node2D, "modulate:a", 0, 2)


func _on_house_player_exited() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(player_camera, "zoom", Vector2(0.6, 0.6), 1).set_trans(Tween.TRANS_QUAD)


func _on_player_update_stats() -> void:
	ui.update_laser_count_display()
	ui.update_grenade_count_display()
