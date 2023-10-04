extends Node2D

var BULLET = preload("res://scenes/bullet.tscn")
var aim = Vector2.ZERO

var shotgun_degree = [-PI/32, 0, PI/32]
var isReload = false

func _ready():
	get_node("hand_pistol").visible = true
	get_node("hand_shotgun").visible = false
	get_node("Timer").wait_time = 0.3

func _physics_process(_delta): 
	aim = global_position.direction_to(get_global_mouse_position())
	
	if Input.is_action_just_pressed("wp1"):
		get_node("hand_pistol").visible = true
		get_node("hand_shotgun").visible = false
		get_node("Timer").wait_time = 0.2
	if Input.is_action_just_pressed("wp2"):
		get_node("hand_pistol").visible = false
		get_node("hand_shotgun").visible = true
		get_node("Timer").wait_time = 0.3

	if Input.is_action_pressed("fire"):
		if not isReload:
			bullet_spawn()
			
	var new_rotation = atan2(aim.y, aim.x)
	rotation_degrees = rad_to_deg(new_rotation)
	
	flip_weapons()
	
func reload():
	$Timer.start()
	isReload = true
	
func _on_timer_timeout():
	isReload = false
	
func bullet_spawn():
	if get_node("hand_pistol").visible ==false:
		for a in shotgun_degree:
			var bulletSpawn = BULLET.instantiate()
			bulletSpawn.direction = aim.rotated(a)
			bulletSpawn.global_position = $hand_shotgun.global_position
			get_parent().get_parent().add_child(bulletSpawn)
		reload()
	elif get_node("hand_pistol").visible == true:
		for a in range (1):
			var bulletSpawn = BULLET.instantiate()
			bulletSpawn.direction = aim.rotated(a)
			bulletSpawn.global_position = $hand_pistol.global_position
			get_parent().get_parent().add_child(bulletSpawn)
		reload()
	
func flip_weapons():
	if rotation_degrees <= -90 or rotation_degrees >= 90:
		get_node("hand_shotgun/Shotgun").flip_v = true
		get_node("hand_shotgun/Shotgun").position.y = -1
		get_node("hand_pistol/Pistol").flip_v = true
		get_node("hand_pistol/Pistol").position.y = -1
	elif rotation_degrees >= -90 or rotation_degrees <= 90:
		get_node("hand_shotgun/Shotgun").flip_v = false
		get_node("hand_shotgun/Shotgun").position.y = 1
		get_node("hand_pistol/Pistol").flip_v = false
		get_node("hand_pistol/Pistol").position.y = 1
