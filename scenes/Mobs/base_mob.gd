# Base Mob Class
class_name BaseMob extends Area2D
signal death

# Base Mob Properties
@export var speed:        int = 70
@export var hit_points:   int = 100
@export var damage:       int = 5

var direction: Vector2 = Vector2.ZERO
var knockback: bool    = false
var target:    Area2D


# Reset animation
func _on_hit_anim_finished() -> void:
	$AnimatedSprite2D.play("walk")

# Hurtbox
func reduce_hit_points(damage: int) -> void:
	hit_points -= damage
	print(get_name(), " hit! taking: ", damage, "remaining HP: ", hit_points)

	if hit_points <= 0:
		death.emit(self.global_position)
		queue_free()
	else:
		$AnimatedSprite2D.play("hit")
		knockback = true

# Call the _on_hit function of the object it has hit
func _on_area_entered(target: Area2D) -> void:
	if target.has_method("reduce_hit_points"):
		target.reduce_hit_points(damage)
		print(self.get_name()," I have hit: ", target.get_name())

func _ready() -> void:
	# Signals
	area_entered.connect(_on_area_entered)
	$AnimatedSprite2D.animation_finished.connect(_on_hit_anim_finished)
	$AnimatedSprite2D.play("walk")

func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2.ZERO
	if not target:
		return 

	if knockback:
		direction -= (target.global_position - global_position).normalized()
		velocity = direction * (speed)
		position += velocity * delta
		await get_tree().create_timer(0.09).timeout
		knockback = false

	direction = (target.global_position - global_position).normalized()
	$AnimatedSprite2D.flip_h = target.global_position.x < global_position.x
	velocity = direction * speed
	position += velocity * delta
