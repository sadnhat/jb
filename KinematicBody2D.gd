extends KinematicBody2D


const JUMP_FORCE = -400
const GRAVITY = 800

var velocity = Vector2()

func _physics_process(delta):
	# Apply gravity
	velocity.y += GRAVITY * delta

	# Handle jump
	if Input.is_action_pressed("ui_accept"):
		velocity.y = JUMP_FORCE

	# Move the bird
	velocity = move_and_slide(velocity, Vector2.UP)

	# Clamp vertical velocity to prevent the bird from flying too fast upwards or falling too fast downwards
	velocity.y = clamp(velocity.y, -600, 600)

 


