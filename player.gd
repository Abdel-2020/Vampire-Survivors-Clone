extends Area2D

# variables
@export var speed: int = 100
var screen_size: Vector2
var hit_count : int

# signals
signal hit
signal position_changed(position: Vector2)

func _on_body_entered(_body: Node2D) -> void:
	print("Hit by: ", _body.get_name())
	hit_count += 1
	print("Hit Count: ", hit_count)
	hit.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	self.body_entered.connect(_on_body_entered)

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
		# print("Velocity Vector = ", velocity.length())
		if(speed < 150):
			speed += 1
			# print(speed)
		# Normalize the vector		
		velocity = velocity.normalized() * (speed)

		# emit position changed.
		position_changed.emit(self.global_position)
		
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
