extends StaticBody2D

## Emitted whenever the player enters the gate's entrance.
## [param body] is the node that collided with the gate's entrance.
signal player_entered_gate(body: Node2D)


func _on_area_2d_body_entered(body: Node2D) -> void:
	player_entered_gate.emit(body)
