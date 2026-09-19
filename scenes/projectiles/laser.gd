extends Area2D

@export var speed: float = 1000.0

var direction := Vector2.UP


func _process(delta: float) -> void:
	position += direction * speed * delta
