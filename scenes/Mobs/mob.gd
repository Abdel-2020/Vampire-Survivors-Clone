extends Area2D
# Variables
@export var speed: int = 70
@export var Player_Path: NodePath
var Player: Area2D = null
var hit_count: int
var direction: Vector2 = Vector2.ZERO
var knockback: bool = false

# We want bats to spawn randomly and slowly move towards the player.
# Spawning can and most likely will be handled within the main scene.
# Need a way to determine if the bat is to the left or right of the player
# (Bat animation only flies towards the right)

# How would we make a mob move?
# Find the player's position vector and move towards that.

# How do we find the player's position?
# This I do not know!
# Answer: Expose a Player_Path variable to the inspector.
#         Once the mob is added to the main scene we can then assign the
#         "Player.tscn" so that our mob can access its' path.

func _on_hit_anim_finished() -> void:
	$AnimatedSprite2D.play("Bat")	
	

func _on_hit() -> void:	
	$AnimatedSprite2D.play("Bat_Hit")
	print(self.get_name(), ": I'm hit!")
	knockback = true

func _on_area_entered(_area: Node2D) -> void:
	print(self.get_name()," I have hit: ", _area.get_name())
	hit_count += 1
	print("Hit Count: ", hit_count)

func _ready() -> void:
	# Signals
	self.area_entered.connect(_on_area_entered)
	$AnimatedSprite2D.animation_finished.connect(_on_hit_anim_finished)
	$AnimatedSprite2D.play("Bat")	

	# Fetch player node using the assigned path
	if Player_Path:
		Player = get_node(Player_Path) as Area2D

func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2.ZERO
	if Player:
		if knockback:
			direction -= (Player.global_position - global_position).normalized()
			velocity = direction * (speed)
			position += velocity * delta
			await get_tree().create_timer(0.06).timeout
			knockback = false

		direction = (Player.global_position - global_position).normalized()
		$AnimatedSprite2D.flip_h = Player.global_position.x < global_position.x
		velocity = direction * speed
		position += velocity * delta
