# Main
extends Node
@export var xp_gem_scene: PackedScene

func drop_xp(drop_location: Vector2) -> void:
	if xp_gem_scene:
		var xp_gem: Area2D = xp_gem_scene.instantiate()
		xp_gem.position    = drop_location

		# Why?
		# Resolve this later
		#E 0:00:09:075 main.gd:12 @ drop_xp(): Can't change this state while flushing queries. Use call_deferred() or set_deferred() to change monitoring state instead.
		#<C++ Error>   Condition "area->get_space() && flushing_queries" is true.
		#<C++ Source>  modules/godot_physics_2d/godot_physics_server_2d.cpp:355 @ area_set_shape_disabled()
		#<Stack Trace> main.gd:12 @ drop_xp()
		#              main.gd:15 @ _on_mob_death()
		#              mob_spawner.gd:23 @ _on_mob_death()
		#              base_mob.gd:26 @ _on_hit()
		#              base_weapon.gd:15 @ _on_area_entered()

		add_child.call_deferred(xp_gem)

func _on_mob_death(mob_position: Vector2) -> void:
	drop_xp(mob_position)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MobSpawner.mob_death.connect(_on_mob_death)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
