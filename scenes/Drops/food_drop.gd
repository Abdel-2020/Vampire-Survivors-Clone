# food consumeable for HP boosts.
class_name Food extends BaseDrop

func _on_consumed(_area: Area2D) -> void:
	if _area.has_method("increase_hit_points"):
		_area.increase_hit_points(25)
		queue_free()
		print("+25 HP")

func _ready() -> void:
	super()
