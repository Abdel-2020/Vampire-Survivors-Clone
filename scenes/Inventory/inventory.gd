# Inventory For Weapons & Buffs
# Will be a child of the Player scene
# Provides a simple interface to persist weapons & buffs (per play session)
# Now how do we go about implementing something like this, store the weapon instance?

extends Node

var max_slots: int = 6
var weapons:   Array
var buffs:     Array

#signals
signal new_weapon
signal new_buff

func store_weapon(weapon: Area2D) -> void:
	weapons.append(weapon)
	print(weapon, " Stored")

	# Emit signal when a new weapon has been stored.
	new_weapon.emit(weapon)

func store_buff(buff: Variant) -> void:
	pass

func get_weapon(weapon_name: String) -> void:
	pass

func get_buff(buff_name: String) -> void:
	pass

func get_list_of_weapons() -> Array:
	return weapons

func get_list_of_buffs() -> Array:
	return buffs


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
