extends Area2D

var speed = 10
var movement = Vector2()
var mouse_pos
var dir
var room_width
var room_height

#Bullet has been created
func init(dir):
	self.add_to_group("Bullet")
	self.dir = dir
	
#Bullet has been placed into the scene
func _ready():
	room_width = get_viewport().size.x
	room_height = get_viewport().size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (position.x < 0 or position.x > room_width or position.y < 0 or position.y > room_height):
		self_destroy()
	movement = movement.move_toward(dir, delta)
	movement = movement.normalized() * speed
	position += movement
	
func self_destroy():
	queue_free()
