class_name Gun

extends Node2D

var ammo_gun = 8
var ammo_left = 0
var ammo
var isROF = false
var isReload = false
var bulletSpeed = 350
var bulletDamage = 0.8
var fireSpeed = 0.35
var reloadTime = 1.0

var gunName = "Pistol"

var pattern = []

@export var gunpoint :Node2D
@export var firespeed: Timer
@export var reloadtime:Timer
@export var BULLET: PackedScene

func _init(_gunName: String, _bulletSpeed: float, _bulletDamage:float, _fireSpeed: float, _reloadTime: float, _pattern):
	gunName = _gunName
	bulletSpeed = _bulletSpeed
	bulletDamage = _bulletDamage
	pattern = _pattern
	fireSpeed = _fireSpeed
	reloadTime = _reloadTime

func _ready():
	firespeed.timeout.connect(_on_fire_speed_timeout)
	reloadtime.timeout.connect(_on_reload_timer_timeout)

func isGunReady():
	ammo_left = ammo_gun
	print("Gun Ammo : ", ammo_left)
	
func enableWeapon():
	var otherWeapons = get_parent().get_children()
	print(otherWeapons)
	get_node(".").visible = true
	for owp in otherWeapons:
		if(owp.name != name):
			if(owp is Node2D):
				owp.visible = false
	firespeed.wait_time = 0.35
	reloadtime.wait_time = 1.0
	
func checkAmmo():
	if ammo_left == ammo_gun:
		ammo = ammo_gun
		print("Gun ammo remain : ", ammo)
	if ammo_left < ammo_gun:
		ammo = ammo_left
		print("Gun ammo remain : ", ammo)
		
func afterProjectileSpawn():
	ammo_left -= 1
	print("Gun Ammo : ", ammo_left)
	rate_of_fire()
	
func rate_of_fire():
	firespeed.start()
	isROF = true

func reload_time():
	reloadtime.start()
	isReload = true
	if ammo_left <= 0:
		ammo_left = ammo_gun

func flipingA():
	get_node(gunName).flip_v = true
	get_node(gunName).position.y = -1

func flipingB():
	get_node(gunName).flip_v = false
	get_node(gunName).position.y = 1
	
func shoot(aim: Vector2):
	spawnBullets(aim)
	afterProjectileSpawn()

func spawnBullets(aim: Vector2):
	for a in pattern:
		#initiate bullet stats
		var bulletSpawn = BULLET.instantiate()
		bulletSpawn.bullet_speed = bulletSpeed
		bulletSpawn.damage = bulletDamage
		bulletSpawn.direction = aim.rotated(a)
		bulletSpawn.global_position = global_position
		get_parent().get_parent().get_parent().add_child(bulletSpawn)

func _on_fire_speed_timeout():
	isROF = false

func _on_reload_timer_timeout():
	isReload = false
	if ammo_left == ammo_gun:
		print("Gun ammo full")
