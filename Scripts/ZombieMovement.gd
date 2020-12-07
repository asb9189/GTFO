extends KinematicBody2D

var speed = 250
var health = 3;
var player_ref
var animation_playing = false
onready var animation_player = get_node("/root/Scene/BloodAnimations")

func _ready():
	self.add_to_group("Enemy")
	player_ref = get_node("/root/Scene/Player")


func _process(delta):
	
	var dir = (player_ref.position - self.position).normalized() * speed
	rotation = (player_ref.position - position).angle()
	move_and_slide(dir)
	
func take_damage(damage):
	health -= damage
	
	if (health <= 0):
		animation_player.visible = true
		animation_player.play()
		animation_player.visible = false
		queue_free()
	else:
		if (not animation_playing):
			animation_playing = true
			animation_player.visible = true
			animation_player.position = position
			animation_player.play()

func _on_BloodAnimations_animation_finished():
	animation_player.visible = false
	animation_player.stop()
	animation_player.set_frame(0)
	animation_playing = false
