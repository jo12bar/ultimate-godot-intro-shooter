extends RigidBody2D

@export var speed: float = 750

@onready var _animation_player: AnimationPlayer = $AnimationPlayer


func explode() -> void:
	_animation_player.play("explosion")
