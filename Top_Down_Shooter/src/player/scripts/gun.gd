class_name Gun

extends Node2D

#var ammo_gun = 8
#var ammo_left = 0
#var ammo
#var isROF = false #rate of fire
#var isReload = false
#var bulletSpeed = 350
#var bulletDamage = 0.8
#var fireSpeed = 0.35
#var reloadTime = 1.0
#var gunName = "Pistol"
#var pattern = []

@export var gunName:String = "Pistol"
@export var ammoGun:int = 8
@export var bulletSpeed: float = 350
@export var bulletDamage: float = .8
@export var fireSpeed: float = 0.35
@export var reloadTime: float = 1.0
@export var bulletSpread: Array = []

@export var gunPoint :Node2D
@export var fireSpeedTimer: Timer
@export var reloadTimeTimer: Timer
@export var BULLET: PackedScene

var ammoLeft: int = 0
var ammo: int
var isRof: bool = false
var isReload: bool = false
var isSignalConnected: bool = false

#func _init(_gunName: String, _bulletSpeed: float, _bulletDamage:float, _fireSpeed: float, _reloadTime: float, _ammo: int, _pattern):
	#gunName = _gunName
	#bulletSpeed = _bulletSpeed
	#bulletDamage = _bulletDamage
	#pattern = _pattern
	#fireSpeed = _fireSpeed
	#reloadTime = _reloadTime
	#ammo_gun = _ammo

#var signals_connected = false

func _ready():
	ammoLeft = ammoGun
	_setup_signals()
	_config_timer()

func _setup_signals():
	if not isSignalConnected:
		if not fireSpeedTimer.timeout.is_connected(_on_fire_speed_timeout):
			fireSpeedTimer.timeout.connect(_on_fire_speed_timeout)
		if not reloadTimeTimer.timeout.is_connected(_on_reload_timer_timeout):
			reloadTimeTimer.timeout.connect(_on_reload_timer_timeout)
		isSignalConnected = true 

func _config_timer():
	fireSpeedTimer.wait_time = fireSpeed
	reloadTimeTimer.wait_time = reloadTime

func isGunReady():
	ammoLeft = ammoGun
	print("Gun Ammo : ", ammoLeft)
	
func enableWeapon():
	visible = true
	for otherWeapons in get_parent().get_children():
		if otherWeapons != self and otherWeapons is Node2D: otherWeapons.visible = false
	_config_timer()
	

	#var otherWeapons = get_parent().get_children()
	#print(otherWeapons)
	#get_node(".").visible = true
	#for owp in otherWeapons:
		#if(owp.name != name):
			#if(owp is Node2D):
				#owp.visible = false
	#firespeed.wait_time = fireSpeed
	#reloadtime.wait_time = reloadTime
	
func checkAmmo():
	ammo = ammoLeft
	print("ammo remain : ", ammo)
	#if ammo_left == ammo_gun:
		#ammo = ammo_gun
		#print("Gun ammo remain : ", ammo)
	#if ammo_left < ammo_gun:
		#ammo = ammo_left
		#print("Gun ammo remain : ", ammo)
		
func afterProjectileSpawn():
	ammoLeft -= 1
	print("Gun Ammo : ", ammoLeft)
	#rate_of_fire()
	_start_fire_cooldown()

func _start_fire_cooldown():
	fireSpeedTimer.start()
	isRof = true

func reload():
	if ammoLeft <= 0:
		reloadTimeTimer.start()
		isReload = true
		ammoLeft = ammoGun
	#reloadtime.start()
	#isReload = true
	#if ammo_left <= 0:
		#ammo_left = ammo_gun

func flip_vertical(is_up:bool):
	var sprite = get_node_or_null(gunName)
	if sprite:
		sprite.flip_v = is_up
		sprite.position.y = -1 if is_up else 1
	#get_node(gunName).flip_v = true
	#get_node(gunName).position.y = -1

#func flipingB():
	#get_node(gunName).flip_v = false
	#get_node(gunName).position.y = 1
	
func shoot(aim: Vector2):
	spawnBullets(aim)
	afterProjectileSpawn()

func spawnBullets(aim: Vector2):
	for angleOffset in bulletSpread:
		#initiate bullet stats
		var bullet = BULLET.instantiate()
		bullet.bullet_speed = bulletSpeed
		bullet.damage = bulletDamage
		bullet.direction = aim.rotated(angleOffset)
		bullet.global_position = global_position
		get_tree().get_root().add_child(bullet)

func _on_fire_speed_timeout():
	isRof = false

func _on_reload_timer_timeout():
	isReload = false
	if ammoLeft == ammoGun: print("Gun ammo full")
