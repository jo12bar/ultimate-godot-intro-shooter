extends LevelParent

@export var inside_level_scene: PackedScene


func _on_gate_player_entered_gate(_body: Node2D) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(player, "speed", 0, 0.5)
	TransitionLayer.change_scene.call_deferred(inside_level_scene)
