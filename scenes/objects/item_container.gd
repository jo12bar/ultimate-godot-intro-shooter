class_name ItemContainer
extends StaticBody2D

## Emitted when the container gets opened. [param position] is the container's
## position in world coordinates, and [param direction] is the direction it's
## facing.
@warning_ignore("unused_signal")
signal container_opened(position: Vector2, direction: Vector2)

## True if the container has already been opened.
var is_open: bool = false

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)


func hit() -> void:
	pass
