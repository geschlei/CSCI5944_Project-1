extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DEATH_FALL_SPEED = 80.0
var alive = true
var hiding = false
const DEATH_DEPTH = 720.0
@onready var game_over_screen = $CanvasLayer/GameOverScreen


func _physics_process(delta: float) -> void:
	if position.y > DEATH_DEPTH and alive:
		die()
		return

	if !alive:
		velocity.x = 0
		velocity.y = DEATH_FALL_SPEED
		move_and_slide()
		return

	
	if !alive:
		velocity.x = 0
		velocity.y = DEATH_FALL_SPEED
		move_and_slide()
		return

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Left/right movement
	var direction := Input.get_axis("left", "right")

	if direction:
		velocity.x = direction * SPEED

		if direction > 0:
			animated_sprite_2d.flip_h = false
		elif direction < 0:
			animated_sprite_2d.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Choose animation
	if not is_on_floor():
		animated_sprite_2d.play("jump_fall")
	elif direction != 0:
		animated_sprite_2d.play("default")
	else:
		animated_sprite_2d.play("default")

	move_and_slide()
	
func die() -> void:
	animated_sprite_2d.animation = "dying"
	alive = false
	await get_tree().create_timer(2.0).timeout
	
	game_over_screen.show()


func _on_try_again_button_pressed() -> void:
	get_tree().reload_current_scene()
