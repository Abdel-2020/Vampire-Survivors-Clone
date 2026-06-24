# Mob Spawner
extends Node2D
signal mob_death

@export var mob_scene:    PackedScene
@export var player:       Area2D
@export var consum:       PackedScene

var mob: Area2D
var chest: Area2D


# Spawn a mob
func _on_timer_timeout() -> void:
	if mob_scene:	
		mob             = mob_scene.instantiate()
		mob.target      = player
		mob.global_position.x  = randi_range(0, 1920)
		mob.global_position.y  = randi_range(0, 1080)

		add_child(mob)
		mob.death.connect(_on_mob_death)

	if consum:
		chest = consum.instantiate()
		chest.global_position.x = randi_range(0, 1920)
		chest.global_position.y = randi_range(0, 1080)
		add_child(chest)

func _on_mob_death(mob_position: Vector2) -> void:
	mob_death.emit(mob_position)

func _ready() -> void:
	$Timer.timeout.connect(_on_timer_timeout)
