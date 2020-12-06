extends KinematicBody2D

var speed = 250
var player_ref

func _ready():
	player_ref = get_node("/root/Scene/Player")


func _process(delta):
	var dir = (player_ref.position - self.position).normalized() * speed
	move_and_slide(dir)
	
	
