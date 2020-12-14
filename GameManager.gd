extends Node2D

#Game State
var wave

#Dependencies
var spawners
var timer

func _ready():
	timer = $Timer
	spawners = get_tree().get_nodes_in_group("Spawner")
	print(spawners)
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.start()

func spawn_wave():
	for spawner in spawners:
		spawner.spawn_zombie()

func _on_timer_timeout():
	spawn_wave()
	timer.start()
