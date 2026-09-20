extends Area2D

## Emitted whenever the player enters the house.
signal player_entered
## Emitted whenever the player exits the house.
signal player_exited


func _on_body_entered(_body: Node2D) -> void:
	player_entered.emit()


func _on_body_exited(_body: Node2D) -> void:
	player_exited.emit()
