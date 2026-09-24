extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


## Fade to black, change the active scene to [param target], and fade to clear.
func change_scene(target: PackedScene) -> void:
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(target)
	animation_player.play("reveal")
