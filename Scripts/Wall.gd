extends StaticBody2D

var hp = 10
var max_hp = 10
onready var repair = get_parent().get_node("repair")

func _ready():
	add_to_group("Wall")

func _process(delta):
	if (hp <= 0):
		visible = false
		$CollisionShape2D.disabled = true
