# Parent Bible class
extends Area2D
# @export var radius: float = 70.0
# @export var speed: float = 2.0
# var Player: Area2D = null
# var angle: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Check who is the parent
#	if get_parent().name.contains('Player'):
#		Player = get_parent()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#	if Player:
		# Orbit around player
#		angle += speed * delta
#		var offset: Vector2 = Vector2(
#			cos(angle) * radius,
#			sin(angle) * radius
#			)
#		global_position = Player.global_position + offset
	pass
