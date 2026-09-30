class_name Item
extends Area2D

## Direction the item will move when spawned. (0, 0) by default, which prevents
## the move-on-spawn behaviour by default.
var direction := Vector2.ZERO
## Distance the item will move when spawned.
var distance: int = randi_range(150, 250)

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

	var target_position = position + direction * distance
	var tween = (create_tween()
		.set_ease(Tween.EASE_OUT)
		.set_trans(Tween.TRANS_EXPO)
		.set_parallel(true))
	tween.tween_property(self, "position", target_position, 0.5)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2(0, 0))


func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.add_item(type)
		if type == ItemType.HEALTH:
			Globals.health += 10
		queue_free()
