extends Node2D

var ammo_pistol = 8
var ammo_left = 0
var ammo
var isROF = false
var isReload = false
var bulletSpeed = 350
var bulletDamage = 0.8

@onready var gunpoint = $".."
@onready var firespeed = $"../FireSpeed"
@onready var reloadtime = $"../ReloadTimer"
@onready var otherWeapons = [
	$"../hand_shotgun",
	$"../hand_smg",
	$"../hand_assalut_rifle"
]

func isGunReady():
	ammo_left = ammo_pistol
	print("Pistol Ammo : ", ammo_left)
	
func isPistol():
	get_node(".").visible = true
	for owp in otherWeapons:
		owp.visible = false
	firespeed.wait_time = 0.35
	reloadtime.wait_time = 1.0
	
func checkAmmo():
	if ammo_left == ammo_pistol:
		ammo = ammo_pistol
		print("Pistol ammo remain : ", ammo)
	if ammo_left < ammo_pistol:
		ammo = ammo_left
		print("Pistol ammo remain : ", ammo)
		
func afterProjectileSpawn():
	ammo_left -= 1
	print("Pistol Ammo : ", ammo_left)
	rate_of_fire()
	
func rate_of_fire():
	firespeed.start()
	isROF = true

func reload_time():
	reloadtime.start()
	isReload = true
	if ammo_left <= 0:
		ammo_left = ammo_pistol

func flipingA():
	get_node("Pistol").flip_v = true
	get_node("Pistol").position.y = -1

func flipingB():
	get_node("Pistol").flip_v = false
	get_node("Pistol").position.y = 1
	
func _on_fire_speed_timeout():
	isROF = false

func _on_reload_timer_timeout():
	isReload = false
	if ammo_left == ammo_pistol:
		print("Pistol ammo full")
