extends Area2D

var speed = 50
var movement = Vector2()
var mouse_pos
var dir

func init(dir):
	self.dir = dir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement = movement.move_toward(dir, delta)
	movement = movement.normalized() * speed
	position += movement
	

func _on_Bullet_body_entered(body):
	if (body.name != "Player"):
		body.health -= 1;
