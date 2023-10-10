extends Node2D

var shotgun_degree = [-PI/16, -PI/32, 0, PI/32, PI/16]
var isFireSPD = false
var isReload = false
var bulletSpawn 
var aim = Vector2.ZERO
var equiped_weapon
var new_weapon
var bullet_speed 
var value 
@onready var BULLET = preload("res://src/projectiles/bullet/scenes/bullet.tscn")
@onready var bulletScript = preload("res://src/projectiles/bullet/scripts/bullet.gd").new()

@onready var weapons = [
	$hand_pistol,
	$hand_shotgun,
	$hand_smg,
	$hand_assalut_rifle
]

func _ready():
	equiped_weapon = weapons[0]
	equiped_weapon.isPistol() 
	for equipedIndexWeapon in weapons:
		equipedIndexWeapon.isGunReady()
	
func _physics_process(_delta):
	aim = global_position.direction_to(get_global_mouse_position())
		
	if Input.is_action_just_pressed("wp1"):
		equiped_weapon = weapons[0]
		equiped_weapon.isPistol()
		equiped_weapon.checkAmmo()
	if Input.is_action_just_pressed("wp2"):
		equiped_weapon = weapons[1]
		equiped_weapon.isShotgun()
		equiped_weapon.checkAmmo()
	if Input.is_action_just_pressed("wp3"):
		equiped_weapon = weapons[2]
		equiped_weapon.isSMG()
		equiped_weapon.checkAmmo()
	if Input.is_action_just_pressed("wp4"):
		equiped_weapon = weapons[3] 
		equiped_weapon.isAR()
		equiped_weapon.checkAmmo()

	if Input.is_action_pressed("fire"):
		if not equiped_weapon.isROF and not equiped_weapon.isReload: #isReload = false
			isFire()
			
	var new_rotation = atan2(aim.y, aim.x)
	rotation_degrees = rad_to_deg(new_rotation)
	flip_weapons()

func isFire():
	if equiped_weapon.get("ammo_left") > 0:
		spawnProjectiles()
		if equiped_weapon.get("ammo_left") <= 0:
			print("reloading . . . I need more boellets")
			equiped_weapon.reload_time()
			
func spawnProjectiles():
	if equiped_weapon != weapons[1]:
		for a in range(1):
			spawnBullets(a)
		equiped_weapon.afterProjectileSpawn()
	if equiped_weapon == weapons[1]:
		for a in shotgun_degree:
			spawnBullets(a)
		equiped_weapon.afterProjectileSpawn()
		
func spawnBullets(a):
	#call constructur
	bulletScript.bullet_speed = equiped_weapon.get("bulletSpeed")
	bulletScript.damage = equiped_weapon.get("bulletDamage")
	print(bulletScript.bullet_speed, " ", bulletScript.damage)
	
	bulletSpawn = BULLET.instantiate()
	bulletSpawn.direction = aim.rotated(a)
	bulletSpawn.global_position = equiped_weapon.global_position
	get_parent().get_parent().add_child(bulletSpawn)	
	
func flip_weapons():
	if rotation_degrees <= -90 or rotation_degrees >= 90:
		equiped_weapon.flipingA()
	elif rotation_degrees >= -90 or rotation_degrees <= 90:
		equiped_weapon.flipingB()
