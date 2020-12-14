extends KinematicBody2D

enum State {RECONNAISANCE, BREAKING_WALL, PURSUING, ATTACKING}

var state
var speed = 250
var health = 3;
var player_ref
var wall_ref
var animation_playing = false
onready var animation_player = get_node("/root/Scene/BloodAnimations")

func _ready():
	self.add_to_group("Enemy")
	state = State.RECONNAISANCE
	
	#get closest window to me
	set_nearest_wall()
	
func change_state():
	if (state == State.RECONNAISANCE):
		state = State.BREAKING_WALL
	
func set_nearest_wall():
	var walls = get_tree().get_nodes_in_group("Wall")
	var closest_wall = walls[0]
	var closest_distance = closest_wall.get_global_position().distance_to(self.get_global_position())
	for wall in walls:
		var dist = wall.get_global_position().distance_to(self.get_global_position())
		if (dist < closest_distance):
			closest_wall = wall
			closest_distance = dist
	wall_ref = closest_wall
	
func set_nearest_player():
	#This is NOT correct (stub)
	player_ref = get_node("/root/Scene/Player")
	
func _process(delta):
	
	if (state == State.RECONNAISANCE):
		var dir = (wall_ref.position - position).normalized() * speed
		rotation = (wall_ref.position - position).angle()
		move_and_slide(dir)
	elif (state == State.BREAKING_WALL):
		wall_ref.hp = 0 #currently destroys the wall instantly
		set_nearest_player() #needs to use path finding with tiles
		state = State.PURSUING
	elif (state == State.PURSUING):
		#print("hunting player")
		var dir = (player_ref.position - position).normalized() * speed
		rotation = (player_ref.position - position).angle()
		move_and_slide(dir)
	elif (state == State.ATTACKING):
		pass
	
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


func _on_Area2D_area_entered(area):
	if (area.get_parent().is_in_group("Wall")):
		change_state()
