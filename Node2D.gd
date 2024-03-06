extends Node2D

export var speed = 200
var player_position = Vector2.ZERO
var game_over = false

func _ready():
	# Connect the game over signal to reload the scene
	connect("game_over", self, "_on_game_over")

func _process(delta):
	if not game_over:
		# Get the player's position
		if not player_position:
			var player = get_node("../Player")  # Assuming the Player node is a direct child of this node
			if player:
				player_position = player.global_position

		# Move the pipe towards the player's position
		position.x -= speed * delta

		# Reset pipe position when it moves off-screen
		if position.x < -100:  # Adjust this value according to your game's requirements
			position = Vector2(800, rand_range(100, 500))  # Adjust the Y position to randomize pipe heights

# Method connected to the body_entered signal of the CollisionShape2D
func _on_Pipe_body_entered(body):
	if body.name == "Player":  # Check if the colliding body is the player
		emit_signal("game_over")  # Emit the game over signal

# Method connected to the game over signal
func _on_game_over():
	game_over = true  # Set the game over flag
	while game_over:  # Wait until game_over flag is false
		yield(get_tree().create_timer(1.0), "timeout")  # Yield to allow the engine to process other events
	get_tree().reload_current_scene() # Reload the current scene to restart the game
