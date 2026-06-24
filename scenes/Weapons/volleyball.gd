class_name Volleyball extends BaseWeapon

@export var rotation_speed: float = 1.0
var rotate: float
var angle:  float = 0.0
var velocity: Vector2 = Vector2.ZERO

# Gives the ball a spinning effect
func rotate_ball() -> void:
	rotate += rotation_speed
	set_rotation_degrees(rotate)

func shoot_ball(delta: float) -> void:
	velocity = Vector2(1,0)
#	angle += speed * delta
#	var offset: Vector2 = Vector2(
#		cos(angle),
#		sin(angle),
#		)
#	global_position = Vector2(200.0, 200.0) + offset

func _on_timer_timeout() -> void:
	# Reset to player's origin
	# Should ideally fire at the next angle, think like a clock hand
	position = Vector2.ZERO
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	$WeaponTimer.timeout.connect(_on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_ball()
	# Shoot Ball Functionality
	# Give the ball a direction
	var direction: Vector2 = Vector2.ZERO
	direction.x = 1
	direction.y = 1
	# Apply speed to that direction
	var velocity: Vector2 = direction * speed
	print(velocity)
	position += velocity * delta
