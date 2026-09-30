extends LevelParent

@export var inside_level_scene: PackedScene


func _on_gate_player_entered_gate(_body: Node2D) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(player, "speed", 0, 0.5)
	TransitionLayer.change_scene.call_deferred(inside_level_scene)


func _on_house_player_entered() -> void:
	var tween := get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(player_camera, "zoom", Vector2(1, 1), 1)


func _on_house_player_exited() -> void:
	var tween := get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(player_camera, "zoom", Vector2(0.6, 0.6), 1)
