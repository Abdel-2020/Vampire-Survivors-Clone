# Inventory For Weapons & Buffs
# Will be a child of the Player scene
# Provides a simple interface to persist weapons & buffs (per play session)
# Now how do we go about implementing something like this?

extends Node

var weapons: Array
var buffs:  Array

func set_weapon(weapon: Variant) -> void:
	weapons.append(weapon)
	print(weapon, " Stored")

func set_buff(buff: Variant) -> void:
	buffs.append(buff)
	print(buff, " Stored")

func get_weapon(weapon: Variant) -> void:
	pass

func get_buff(buff: Variant) -> void:
	pass

func get_all_weapons() -> void:
	print(weapons)

func get_all_buffs() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
