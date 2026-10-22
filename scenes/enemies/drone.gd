extends CharacterBody2D

@export var health: int = 50
@export var speed: int = 400
@export var max_speed: int = 800
@export var explosion_radius: float = 400

var active: bool = false
var can_get_hit: bool = true
var explosion_active: bool = false

@onready var hit_invulnerability_timer: Timer = $Timers/HitInvulnerabilityTimer
@onready var explosion_animation_player: AnimationPlayer = $ExplosionAnimationPlayer
@onready var hurt_animation_player: AnimationPlayer = $HurtAnimationPlayer


func _ready() -> void:
	explosion_animation_player.play("RESET")
	hurt_animation_player.play("RESET")


func _process(_delta: float) -> void:
	if explosion_active:
		# Hit anything close enough to the exploding drone
		var targets := get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
		for hittable in targets:
			var hittable_node2d := hittable as Node2D
			if hittable_node2d and "hit" in hittable_node2d:
				var in_range := hittable_node2d.global_position.distance_to(global_position) <= explosion_radius
				if in_range:
					hittable_node2d.hit.call_deferred()


func _physics_process(delta: float) -> void:
	if active:
		look_at(Globals.player_position)
		var direction = (Globals.player_position - position).normalized()
		velocity = direction * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			explosion_animation_player.play("explosion")


func hit(damage_amount: int = 10) -> void:
	if can_get_hit:
		health -= damage_amount
		can_get_hit = false
		hurt_animation_player.play("invulnerability_blink")
		if health <= 0:
			explosion_animation_player.play("explosion")
		else:
			hit_invulnerability_timer.start()


func explode() -> void:
	active = false
	explosion_active = true


func _on_notice_area_2d_body_entered(_body: Node2D) -> void:
	if health > 0:
		active = true


func _on_hit_invulnerability_timer_timeout() -> void:
	can_get_hit = true

	# only stop the blink animation if the drone is not busy dying
	if health > 0:
		hurt_animation_player.play("RESET")
