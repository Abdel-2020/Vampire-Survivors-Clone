extends CharacterBody2D

# Variables
@export var hit_points: int = 100
@export var speed: int = 100
@export var player_path: NodePath
var player: Area2D = null

# We want bats to spawn randomly and slowly move towards the player.
# Spawning can and most likely will be handled within the main scene.
# Need a way to determine if the bat is to the left or right of the player
# (Bat animation only flies towards the right)


# How would we make a mob move?
# Find the player's position vector and move towards that.

# How do we find the player's position?
# This I do not know!
# Answer: Expose a player_path variable to the inspector.
#         Once the mob is added to the main scene we can then assign the
#         "Player.tscn" so that our mob can access its' path.

func _ready() -> void:
	$AnimatedSprite2D.play("Bat_Flying_Right")

	# Fetch player node using the assigned path
	if player_path:
		player = get_node(player_path) as Area2D

func _physics_process(delta: float) -> void:
	if player:
		var direction: Vector2 = (player.global_position - global_position).normalized()
		$AnimatedSprite2D.flip_h = player.global_position.x < global_position.x
		velocity = direction * speed
		move_and_slide()
