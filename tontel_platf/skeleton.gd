extends KinematicBody2D

var to_right = true
var motion = Vector2()
var gravity = 15
var speed = 50

func _ready():
	$skeleton_sprite.play("walk")

func _physics_process(delta):
	movement()
	detect_turn()

func movement():
	motion.x = -speed if to_right else speed
	motion.y += gravity
	motion = move_and_slide(motion, Vector2.UP)

func detect_turn():
	if not $RayCast2D.is_colliding() and is_on_floor():
		to_right = !to_right
		scale.x = -scale.x
