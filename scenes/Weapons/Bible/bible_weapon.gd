# Bible Weapon
extends BaseWeapon

# Bible Specific Properties
@export var angle:  float  = 0.0
var Player: Area2D = null

# call the _ready() of the BaseWeapon class
func _ready() -> void:
	super()
	if get_parent().name.contains('Player'):
		Player = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if Player:
		# Orbit around player
		angle += speed * delta
		var offset: Vector2 = Vector2(
			cos(angle) * aoe,
			sin(angle) * aoe
			)
		global_position = Player.global_position + offset

	
