# XP Drop
class_name XpGem extends BaseDrop

func _on_consumed(_area: Area2D) -> void:
	print("+25 xp")
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
