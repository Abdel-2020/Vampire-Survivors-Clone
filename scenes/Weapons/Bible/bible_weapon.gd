extends Area2D
@export var radius: float = 100.0
@export var speed: float = 5.0
var Player: Area2D = null
var angle: float = 0.0

func _on_area_entered(_area: Area2D) -> void:
	if(_area.get_name().contains("Mob")):
		print(self.get_name()," I have hit: ", _area.get_name())
		_area._on_hit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
# Check who is the parent
	if get_parent().name.contains('Player'):
		Player = get_parent()
		print("Player is: ", Player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if Player:
		# Orbit around player
		angle += speed * delta
		var offset: Vector2 = Vector2(
			cos(angle) * radius,
			sin(angle) * radius
			)
		global_position = Player.global_position + offset

	
