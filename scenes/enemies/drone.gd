extends CharacterBody2D


const SPEED = 300.0


func _physics_process(_delta: float) -> void:
	velocity = Vector2.RIGHT * SPEED
	
	move_and_slide()


func hit() -> void:
	print("damage")
