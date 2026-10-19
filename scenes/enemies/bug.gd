extends CharacterBody2D

@export var health: int = 20
@export var speed: float = 300
@export var damage: int = 10

var player_in_notice_range: bool = false
var player_in_attack_range: bool = false
var can_get_hit: bool = true
var can_attack: bool = true

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_invulnerability_timer: Timer = $Timers/HitInvulnerabilityTimer
@onready var attack_cooldown_timer: Timer = $Timers/AttackCooldownTimer
@onready var hurt_box_2d: Area2D = $HurtBoxArea2D
@onready var hit_particles: GPUParticles2D = $Particles/HitParticles


func _process(_delta: float) -> void:
	if player_in_attack_range and can_attack and health > 0:
		can_attack = false
		attack_in_area()
		attack_cooldown_timer.start()


func _physics_process(_delta: float) -> void:
	if animated_sprite_2d.animation != "attack" and player_in_notice_range and health > 0:
		look_at(Globals.player_position)
		if player_in_attack_range:
			velocity = Vector2.ZERO
		else:
			velocity = (Globals.player_position - position).normalized() * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO


func hit(damage_amount: int = 10) -> void:
	if can_get_hit:
		health -= damage_amount
		hit_particles.emitting = true
		animation_player.play("invulnerability_blink")
		if health <= 0:
			# wait before dying so the particles can play a bit
			await get_tree().create_timer(0.5).timeout
			queue_free()
		else:
			can_get_hit = false
			hit_invulnerability_timer.start()


func attack_in_area() -> void:
	animated_sprite_2d.play("attack")
	await animated_sprite_2d.animation_finished

	for body in hurt_box_2d.get_overlapping_bodies():
		var player_body := body as Player
		if player_body:
			player_body.hit(damage)

	if player_in_notice_range:
		animated_sprite_2d.play("walk")


func start_noticing_player() -> void:
	player_in_notice_range = true
	animated_sprite_2d.play("walk")


func stop_noticing_player() -> void:
	player_in_notice_range = true
	animated_sprite_2d.play("walk")


func _on_hit_invulnerability_timer_timeout() -> void:
	can_get_hit = true
	animation_player.stop()

	# only stop the blink animation if the bug is not busy dying
	if health > 0:
		animation_player.play("RESET")


func _on_notice_area_2d_body_entered(_body: Node2D) -> void:
	start_noticing_player()


func _on_notice_area_2d_body_exited(_body: Node2D) -> void:
	stop_noticing_player()


func _on_attack_area_2d_body_entered(_body: Node2D) -> void:
	player_in_attack_range = true


func _on_attack_area_2d_body_exited(_body: Node2D) -> void:
	player_in_attack_range = false


func _on_attack_cooldown_timer_timeout() -> void:
	can_attack = true
