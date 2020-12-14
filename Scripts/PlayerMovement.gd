extends KinematicBody2D

#raycast
onready var ray = $RayCast2D

#bullet timer
var timer
var canShoot = true

#ammo
var maxAmmo = 32
var currentAmmo = 32

#ammo (clip)
var maxClipAmmo = 8
var currentClipAmmo = 8

#movement
var velocity = Vector2()
export (int) var speed = 400

#ammo UI
var ammo_ui

#weapon stats
var currentWeapon = 1
var currentWeaponDamage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#project settings to disable mouse visuals
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	#Add to player group
	add_to_group("Player")
	
	#get the timer
	timer = $Timer
	timer.connect("timeout", self, "_on_timer_timeout")
	
	#set the UI
	ammo_ui = get_parent().get_node("ammo")
	ammo_ui.set_text(str(maxClipAmmo) + "/" + str(maxAmmo))
	
func _on_timer_timeout():
	canShoot = true

func get_input():
	velocity = Vector2()
	var canReload = true
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if Input.is_action_just_released("mouse_left"):
		if (canShoot and currentClipAmmo > 0):
			fire_bullet()
			canReload = false
	if Input.is_action_just_pressed("reload"):
		if (canReload):
			reload()
	velocity = velocity.normalized() * speed
	
func reload():
	if (currentAmmo > 0 and currentClipAmmo < maxClipAmmo):
		while(currentAmmo > 0 and currentClipAmmo != maxClipAmmo):
			currentClipAmmo += 1
			currentAmmo -= 1
	update_ammo_ui()
	
func update_ammo_ui():
	ammo_ui.set_text(str(currentClipAmmo) + "/" + str(currentAmmo))

func fire_bullet():
	if (ray.is_colliding() and ray.get_collider().is_in_group("Enemy")):
		ray.get_collider().take_damage(currentWeaponDamage)
	canShoot = false
	currentClipAmmo -= 1
	update_ammo_ui()
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	rotation = (get_global_mouse_position() - global_position).angle()
	velocity = move_and_slide(velocity)


func _on_Area2D_area_entered(area):
	if (area.get_parent().is_in_group("Wall")):
		pass
