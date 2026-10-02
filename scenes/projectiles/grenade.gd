extends RigidBody2D

@export var speed: float = 750
@export var explosion_radius: float = 400

var explosion_active: bool = false

@onready var _animation_player: AnimationPlayer = $AnimationPlayer


func _process(_delta: float) -> void:
	if explosion_active:
		# Hit anything close enough to the grenade
		var targets := get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
		for hittable in targets:
			var hittable_node2d := hittable as Node2D
			if hittable_node2d and "hit" in hittable_node2d:
				var in_range := hittable_node2d.global_position.distance_to(global_position) <= explosion_radius
				if in_range:
					hittable_node2d.hit.call_deferred()


func explode() -> void:
	_animation_player.play("explosion")
	explosion_active = true
