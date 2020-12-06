extends KinematicBody2D

var velocity = Vector2()
export (int) var speed = 400;
onready var bulletScene = preload("res://Scenes/BulletScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED) #project settings to disable mouse visuals
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
	if Input.is_action_just_released("mouse_left"):
		var direction = (get_global_mouse_position() - global_position).normalized()
		var bullet = bulletScene.instance()
		bullet.init(direction)
		bullet.set_global_position(position)
		get_parent().add_child(bullet)
		
		
	velocity = velocity.normalized() * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	rotation = (get_global_mouse_position() - global_position).angle()
	velocity = move_and_slide(velocity)
