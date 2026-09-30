class_name Item
extends Area2D

@export var rotation_speed: float = 4.0

enum ItemType { LASER, GRENADE, HEALTH }
var _available_item_types: Array[ItemType] = [ItemType.LASER, ItemType.GRENADE, ItemType.HEALTH]
var _item_type_weights := PackedFloat32Array([4.0/6.0,        1.0/6.0,          1.0/6.0])

var rng = RandomNumberGenerator.new()

var type: ItemType = _available_item_types[rng.rand_weighted(_item_type_weights)]

@onready var _sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if type == ItemType.LASER:
		_sprite.modulate = Color(0.1, 0.2, 0.8)
	elif type == ItemType.GRENADE:
		_sprite.modulate = Color(0.8, 0.2, 0.1)
	elif type == ItemType.HEALTH:
		_sprite.modulate = Color(0.1, 0.8, 0.1)


func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.add_item(type)
		if type == ItemType.HEALTH:
			Globals.health += 10
		queue_free()
