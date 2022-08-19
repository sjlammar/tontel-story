extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()
var gravity = 15
var acceleration = 5
var max_speed = 60
var jump_force = -180
var jump_count = 0
var friction = false

func _physics_process(delta):
	movement()
	animate()
	gravity()

func movement():
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+acceleration, max_speed)
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-acceleration, -max_speed)
	else :
		motion.x = lerp(motion.x, 0, 0.3)

	if Input.is_action_just_pressed("ui_up") && jump_count < 2:
		motion.y = jump_force
		jump_count +=1

	motion = move_and_slide(motion, UP)

func gravity():
	if is_on_floor():
		motion.y= 0
		jump_count = 0
	else :
		motion.y += gravity

func animate():
	if motion.x > 0:
		$MC_sprite.flip_h = false
		$MC_sprite.play("default")
	elif motion.x < 0 :
		$MC_sprite.flip_h = true
		$MC_sprite.play("default")
	else :
		$MC_sprite.play("default")
