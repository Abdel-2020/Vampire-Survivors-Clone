extends Area2D

# Create instance of a scene.
var Weapon: PackedScene = preload("res://scenes/Weapons/Bible/bible_weapon.tscn")

# variable
@export var speed: int = 100
var screen_size: Vector2

# signals
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	
	if Weapon:
		var weapon_instance: Area2D = Weapon.instantiate()
		add_child(weapon_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	# Initialize and Reset Velocity Vector
	var velocity: Vector2 = Vector2.ZERO	
	
	# If the player is pressing a direction,
	# set the vector to that direction.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		# print("Move Right Clicked: ", velocity.x)
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		# print("Move Left Clicked: ", velocity.x)
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		# print("Move Down Clicked: ", velocity.y)
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		# print("Move Up Clicked: ", velocity.y)

	# Apply speed to the direction, normalize the vector.
	if velocity.length() > 0:
		# Normalize the vector		
		velocity = velocity.normalized() * (speed)

		# Play animations	
		if velocity.x != 0 and velocity.y != 0:
			if velocity.y > 0:
				$AnimatedSprite2D.play("Walk_Down_Right")
				$AnimatedSprite2D.flip_h = velocity.x < 0
			else:
				$AnimatedSprite2D.play("Walk_Up_Right")
				$AnimatedSprite2D.flip_h = velocity.x < 0
		# Left Right
		elif velocity.x != 0:
			$AnimatedSprite2D.play("Walk_Right") 
			$AnimatedSprite2D.flip_h = velocity.x < 0 	
		# Up, Down
		elif velocity.y > 0:
			$AnimatedSprite2D.play("Walk_Down")
		elif velocity.y < 0:
			$AnimatedSprite2D.play("Walk_Up")			
	
	else:
		$AnimatedSprite2D.play("Idle_Down")
		#$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)	
