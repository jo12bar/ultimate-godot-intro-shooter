class_name LevelParent
extends Node2D

const LASER_SCENE: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const GRENADE_SCENE: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
const ITEM_SCENE: PackedScene = preload("res://scenes/items/item.tscn")

@onready var items: Node2D = $Items
@onready var projectiles: Node2D = $Projectiles
@onready var player: CharacterBody2D = $Player
@onready var player_camera: Camera2D = $Player/Camera2D
@onready var ui: Ui = $UI


func _ready() -> void:
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("container_opened", _on_container_opened)

	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect("laser_fired", _on_scout_laser_fired)


func _on_container_opened(pos: Vector2, direction: Vector2) -> void:
	var item: Item = ITEM_SCENE.instantiate()
	item.position = pos
	item.direction = direction

	items.add_child.call_deferred(item)


func _on_player_laser_fired(spawn_pos: Vector2, direction: Vector2) -> void:
	fire_laser(spawn_pos, direction)


func _on_player_grenade_fired(spawn_pos: Vector2, direction: Vector2) -> void:
	var grenade: RigidBody2D = GRENADE_SCENE.instantiate()

	# set grenade position so it comes from the player's gun
	grenade.position = spawn_pos
	grenade.linear_velocity = direction * grenade.speed

	# add the grenade instance to a Node2D
	projectiles.add_child(grenade)


func _on_scout_laser_fired(spawn_pos: Vector2, direction: Vector2) -> void:
	fire_laser(spawn_pos, direction)


func fire_laser(spawn_pos: Vector2, direction: Vector2) -> void:
	var laser: Node2D = LASER_SCENE.instantiate()

	# set laser position so it comes from the correct location
	laser.position = spawn_pos
	laser.rotation = direction.angle() + PI/2.0
	laser.direction = direction

	# add the laser instance to a Node2D
	projectiles.add_child(laser)
