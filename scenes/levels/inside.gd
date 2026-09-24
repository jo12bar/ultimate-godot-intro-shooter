extends LevelParent

@onready var outside_scene: PackedScene = load("res://scenes/levels/outside.tscn")


func _on_exit_gate_area_body_entered(_body: Node2D) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(player, "speed", 0, 0.5)
	TransitionLayer.change_scene.call_deferred(outside_scene)
