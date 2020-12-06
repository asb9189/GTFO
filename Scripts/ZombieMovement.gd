extends KinematicBody2D

var speed = 250
var health = 3;
var player_ref

func _ready():
	player_ref = get_node("/root/Scene/Player")


func _process(delta):
	
	if (health <= 0):
		queue_free()
	
	var dir = (player_ref.position - self.position).normalized() * speed
	rotation = (player_ref.position - position).angle()
	move_and_slide(dir)
	
