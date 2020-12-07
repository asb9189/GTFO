extends KinematicBody2D

var speed = 250
var health = 3;
var player_ref
var animation_playing = false
onready var animation_player = $"AnimatedSprite"

func _ready():
	player_ref = get_node("/root/Scene/Player")


func _process(delta):
	
	if (health <= 0):
		queue_free()
	
	var dir = (player_ref.position - self.position).normalized() * speed
	rotation = (player_ref.position - position).angle()
	move_and_slide(dir)
	

func _on_Area2D_area_entered(area):
	if (area.name == "Bullet"):
		health -= 1;
		
		if (not animation_playing):
			animation_playing = true
			animation_player.visible = true
			animation_player.play("blood_splash_1")
			
		area.self_destroy()
		


func _on_AnimatedSprite_animation_finished():
	animation_player.visible = false
	animation_player.stop()
	animation_player.set_frame(0)
	animation_playing = false
	
