# Chest for a random weapon upgrade.
class_name Chest extends BaseDrop

func _on_area_entered(area: Area2D) -> void:
	# Player should have a list of their equipped weapons.
	# Select a random weapon and increase it's level

	# For now this is good enough:
	if area.find_child("Inventory"):
		var inventory:        Node = area.find_child("Inventory")
		var list_of_weapons: Array = inventory.get_list_of_weapons()
		print(list_of_weapons)


func _ready() -> void:
	super()
