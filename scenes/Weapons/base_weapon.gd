# Base Weapon Class
extends Area2D
class_name BaseWeapon

# Base Weapon Properties
# A weapon can have:
#
# Damage,
# Speed,
# Range (travel),
# Area Of Effect (size),
# Number of Projectile(s),
# Frequency (cooldowns),
# Rebound/Travel through enemies

# Multipliers should be able to alter these values
# For example speed buff speed += (speed*multiplier)

# A weapon also needs to cooldown after a short period of time.

@export var speed:               float = 1.0
@export var damage:              int
@export var weapon_range:        int
@export var aoe:                 float = 60.0
@export var no_of_projectiles:   int   = 1
@export var cooldown_duration:   float = 3.0
@export var rebound_value:       int

var player:    Area2D = null
var is_active: bool   = true


# Weapon Timer
# Display the weapon during it's attack cycle
# Hide the weapon during cooldown cycle
# Need to refactor/cleanup/fix/whatever

func _on_timer_timeout() -> void:
	if is_active:
		cooldown(cooldown_duration)
	else:
		is_active                  = true
		visible                    = true
		$CollisionShape2D.disabled = false


func cooldown(cooldown_duration: float) -> void:
	is_active                  = false
	visible                    = false
	$CollisionShape2D.disabled = true
	$WeaponTimer.wait_time     = cooldown_duration
	$WeaponTimer.start()

# ??????????
func increase_property(_property_name: String, value: Variant) -> void:
	if get(_property_name):
		speed += value
	pass

func decrease_property(_property_name: String, value: Variant) -> void:
	pass

# When colliding with a mob:
# Check whether they have _on_hit function.
# If they do, execute the function and pass the damage argument.

func _on_area_entered(target: Area2D) -> void:
	if target.has_method("reduce_hit_points"):
		target.reduce_hit_points(damage)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
	$WeaponTimer.timeout.connect(_on_timer_timeout)
