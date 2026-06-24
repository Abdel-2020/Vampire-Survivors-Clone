# Player Class
extends Area2D
signal dead

# Variables
@export var max_hit_points: int = 100
@export var hit_points:     int = 100
@export var speed:          int = 120

var Starting_Weapon:  PackedScene = preload("res://scenes/Weapons/Bible/bible_weapon.tscn")
var screen_size:      Vector2

# Increase HP (called when player picks up a health consum)
func increase_hit_points(value: int) -> void:
	hit_points += value
	hit_points = min(hit_points, max_hit_points)
	print(hit_points)

func reduce_hit_points(damage: int) -> void:
	hit_points -= damage
	if hit_points <= 0:
		dead.emit()
		print("Dead")	
		queue_free()
	print("Taking damage: ", damage)

func _on_new_weapon(weapon: Area2D) -> void:
	print("New weapon: ", weapon, " added as child node")
	add_child(weapon)

func _ready() -> void:
	$Inventory.new_weapon.connect(_on_new_weapon)
	screen_size = get_viewport_rect().size

	if Starting_Weapon:
		var weapon_instance: Area2D = Starting_Weapon.instantiate()
		$Inventory.store_weapon(weapon_instance)


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
		velocity = velocity.normalized() * speed

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
