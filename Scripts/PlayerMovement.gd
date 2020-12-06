extends KinematicBody2D

export (int) var speed = 200;
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	get_input()
	look_at(mouse_pos)
	velocity = move_and_slide(velocity)
