extends Node2D

var ammo_shotgun = 5
var ammo_left = 0
var ammo
var isROF = false
var isReload = false
var bulletSpeed = 300
var bulletDamage = 0.5

@onready var gunpoint = $".."
@onready var firespeed = $"../FireSpeed"
@onready var reloadtime = $"../ReloadTimer"
@onready var otherWeapons = [
	$"../hand_pistol",
	$"../hand_smg",
	$"../hand_assalut_rifle"
]

func isGunReady():
	ammo_left = ammo_shotgun
	print("Shotgun Ammo : ", ammo_left)
	
func isShotgun():
	get_node(".").visible = true
	for owp in otherWeapons:
		owp.visible = false
	firespeed.wait_time = 0.8
	reloadtime.wait_time = 1.5

func checkAmmo():
	if ammo_left == ammo_shotgun:
		ammo = ammo_shotgun
		print("Shotgun ammo remain : ", ammo)
	if ammo_left < ammo_shotgun:
		ammo = ammo_left
		print("Shotgun ammo remain : ", ammo)
		
func afterProjectileSpawn():
	ammo_left -= 1
	print("Shotgun Ammo : ", ammo_left)
	rate_of_fire()
	
func rate_of_fire():
	firespeed.start()
	isROF = true

func reload_time():
	reloadtime.start()
	isReload = true
	if ammo_left <= 0:
		ammo_left = ammo_shotgun

func flipingA():
	get_node("Shotgun").flip_v = true
	get_node("Shotgun").position.y = -1

func flipingB():
	get_node("Shotgun").flip_v = false
	get_node("Shotgun").position.y = 1

func _on_fire_speed_timeout():
	isROF = false

func _on_reload_timer_timeout():
	isReload = false
	if ammo_left == ammo_shotgun:
		print("Shotgun ammo full")
