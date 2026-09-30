extends ItemContainer

@onready var lid_sprite: Sprite2D = $LidSprite
@onready var spawn_positions: Node2D = $SpawnPositions


func hit() -> void:
	if !is_open:
		lid_sprite.hide()
		for i in range(5):
			var spawn_pos := spawn_positions.get_child(randi() % spawn_positions.get_child_count()) as Node2D
			container_opened.emit(spawn_pos.global_position, current_direction)
	is_open = true
