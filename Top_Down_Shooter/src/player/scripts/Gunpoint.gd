extends Node2D

var shotgun_degree = [-PI/16, -PI/32, 0, PI/32, PI/16]
var isFireSPD = false
var isReload = false
var bulletSpawn 
var aim = Vector2.ZERO
var equipped_weapon
var new_weapon
var bullet_speed 
var value 
@onready var BULLET = preload("res://src/projectiles/bullet/scenes/bullet.tscn")

@onready var weapons = [
	$hand_pistol,
	$hand_shotgun,
	$hand_smg,
	$hand_assalut_rifle
]

func _ready():
	equipped_weapon = weapons[0]
	equipped_weapon.enableWeapon()
	for equipedIndexWeapon in weapons:
		equipedIndexWeapon.isGunReady()
	
func _physics_process(_delta):
	aim = global_position.direction_to(get_global_mouse_position())
		
	if Input.is_action_just_pressed("wp1"):
		equipped_weapon = weapons[0]
		get_parent().emit_signal("set_selected_weapon", equipped_weapon.weapon_number)
		equipped_weapon.enableWeapon()
		equipped_weapon.checkAmmo()
	if Input.is_action_just_pressed("wp2"):
		equipped_weapon = weapons[1]
		get_parent().emit_signal("set_selected_weapon", equipped_weapon.weapon_number)
		equipped_weapon.enableWeapon()
		equipped_weapon.checkAmmo()
	if Input.is_action_just_pressed("wp3"):
		equipped_weapon = weapons[2]
		get_parent().emit_signal("set_selected_weapon", equipped_weapon.weapon_number)
		equipped_weapon.enableWeapon()
		equipped_weapon.checkAmmo()
	if Input.is_action_just_pressed("wp4"):
		equipped_weapon = weapons[3] 
		get_parent().emit_signal("set_selected_weapon", equipped_weapon.weapon_number)
		equipped_weapon.enableWeapon()
		equipped_weapon.checkAmmo()

	if Input.is_action_pressed("fire"):
		if not equipped_weapon.isROF and not equipped_weapon.isReload: #isReload = false
			isFire()
			
	var new_rotation = atan2(aim.y, aim.x)
	rotation_degrees = rad_to_deg(new_rotation)
	flip_weapons()

func isFire():
	if equipped_weapon.get("ammo_left") > 0:
		spawnProjectiles()
		if equipped_weapon.get("ammo_left") <= 0:
			print("reloading . . . I need more boellets")
			equipped_weapon.reload_time()
			
func spawnProjectiles():
	equipped_weapon.shoot(aim)
#	if equipped_weapon != weapons[1]:
#		for a in range(1):
#			spawnBullets(0)
#		equipped_weapon.afterProjectileSpawn()
#	if equipped_weapon == weapons[1]:
#		for a in shotgun_degree:
#			spawnBullets(a)
#		equipped_weapon.afterProjectileSpawn()
		
func spawnBullets(a):
	#initiate bullet stats
	bulletSpawn = BULLET.instantiate()
	bulletSpawn.bullet_speed = equipped_weapon.get("bulletSpeed")
	bulletSpawn.damage = equipped_weapon.get("bulletDamage")
	bulletSpawn.direction = aim.rotated(a)
	bulletSpawn.global_position = equipped_weapon.global_position
	get_parent().get_parent().add_child(bulletSpawn)
	
func flip_weapons():
	if rotation_degrees <= -90 or rotation_degrees >= 90:
		equipped_weapon.flipingA()
	elif rotation_degrees >= -90 or rotation_degrees <= 90:
		equipped_weapon.flipingB()
