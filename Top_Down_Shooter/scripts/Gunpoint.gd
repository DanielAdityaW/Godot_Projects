extends Node2D

const BULLET = preload("res://scenes/bullet.tscn")
var aim = Vector2.ZERO
var shotgun_degree = [-PI/16, -PI/32, 0, PI/32, PI/16]
var isFireSPD = false
var isReload = false
var bulletSpawn 
var ammo_left_ps = 0
var ammo_left_sg = 0
var ammo
var pistol_ammo = 8
var shotgun_ammo = 6

func _ready():
	get_node("hand_pistol").visible = true
	get_node("hand_shotgun").visible = false
	get_node("FireSpeed").wait_time = 0.35
	get_node("ReloadTimer").wait_time = 0.6
	ammo_left_ps = pistol_ammo
	ammo_left_sg = shotgun_ammo

func _physics_process(_delta): 
	aim = global_position.direction_to(get_global_mouse_position())
	
	if Input.is_action_just_pressed("wp1"):
		get_node("hand_pistol").visible = true
		get_node("hand_shotgun").visible = false
		get_node("FireSpeed").wait_time = 0.35
		get_node("ReloadTimer").wait_time = 0.6
		ammo = pistol_ammo
		if ammo_left_ps < pistol_ammo:
			ammo = ammo_left_ps
			print("Pistol ammo left: ", ammo)
		
	if Input.is_action_just_pressed("wp2"):
		get_node("hand_pistol").visible = false
		get_node("hand_shotgun").visible = true
		get_node("FireSpeed").wait_time = 0.7
		get_node("ReloadTimer").wait_time = 1
		ammo = shotgun_ammo
		if ammo_left_sg < shotgun_ammo:
			ammo = ammo_left_sg
			print("Shotgun ammo left :", ammo)
		
	if Input.is_action_pressed("fire"):
		if not isReload and not isFireSPD: #isReload = true
			bullet_spawn()
			
	var new_rotation = atan2(aim.y, aim.x)
	rotation_degrees = rad_to_deg(new_rotation)
	flip_weapons()

func bullet_spawn():
	if ammo_left_ps > 0 or ammo_left_sg > 0:
		#equip pistol
		if get_node("hand_pistol").visible == true:
			for a in range (1):
				bulletSpawn = BULLET.instantiate()
				bulletSpawn.direction = aim.rotated(a)
				bulletSpawn.global_position = $hand_pistol.global_position
				get_parent().get_parent().add_child(bulletSpawn)
			ammo_left_ps -= 1
			fireSpeed()
			print("Pistol fire chance :", ammo_left_ps)
			
		#equip shotgun
		if get_node("hand_shotgun").visible == true:
			for a in shotgun_degree:
				bulletSpawn = BULLET.instantiate()
				bulletSpawn.direction = aim.rotated(a)
				bulletSpawn.global_position = $hand_shotgun.global_position
				get_parent().get_parent().add_child(bulletSpawn)
			ammo_left_sg -= 1
			fireSpeed()
			print("Shotgun fire chance :", ammo_left_sg)
				
	if ammo_left_ps <= 0 or ammo_left_sg <= 0:
		print("reloading")
		reloading()
		
func fireSpeed():
	$FireSpeed.start()
	isFireSPD = true
	
func reloading():
	$ReloadTimer.start()
	isReload = true
	if ammo_left_ps <= 0:
		ammo_left_ps = pistol_ammo
	if ammo_left_sg <= 0:
		ammo_left_sg = shotgun_ammo
	
func _on_timer_timeout():
	isFireSPD = false

func _on_reload_timer_timeout():
	isReload = false
	print("reload is finish, now shoot!!")
	
func flip_weapons():
	if rotation_degrees <= -90 or rotation_degrees >= 90:
		#flip pistol
		get_node("hand_pistol/Pistol").flip_v = true
		get_node("hand_pistol/Pistol").position.y = -1
		#flip shotgun
		get_node("hand_shotgun/Shotgun").flip_v = true
		get_node("hand_shotgun/Shotgun").position.y = -1
		
	elif rotation_degrees >= -90 or rotation_degrees <= 90:
		#unflip pistol
		get_node("hand_pistol/Pistol").flip_v = false
		get_node("hand_pistol/Pistol").position.y = 1
		#unflip shotgun
		get_node("hand_shotgun/Shotgun").flip_v = false
		get_node("hand_shotgun/Shotgun").position.y = 1
