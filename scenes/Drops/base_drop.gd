# Base Drop
class_name BaseDrop extends Area2D
signal consumed

var spawn_location: Vector2

# What is a drop?
# A consumable that sits in the world and awaits to be picked up.
# May or may not have a predefined location.
# Example: A secret that sits in the world vs an XP drop from a killed mob.
#
# May or may not have an animation.
# Example: floating/glowing/both vs static?
#
# May or may not provide immediate benefit.
# Example: HP/XP vs Randomized chest drop, which requires a game pause to offer player choice.

# Base Behaviors:
# Emit a signal when player has entered hitbox.
#
# Child classes will override behavior with their own unique functionality.
# For example a weapon will attach to a player, xp gems will add to the player's total xp,
# chests will provide the player with a random upgrade and food will restore HP.


# When player collides with drop
func _on_area_entered(_area: Area2D) -> void:
	consumed.emit(_area)

# Consume functionality
# base drop will just disappear
func _on_consumed(_area: Area2D) -> void:
	print(_area)
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	consumed.connect(_on_consumed)
	area_entered.connect(_on_area_entered)
