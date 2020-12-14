extends Node2D

var Zombie = preload("res://Scenes/ZombieScene.tscn")

func _ready():
	add_to_group("Spawner")

func spawn_zombie():
	var zombie = Zombie.instance()
	zombie.position = self.position
	get_parent().add_child(zombie)
