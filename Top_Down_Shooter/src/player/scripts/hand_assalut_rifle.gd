extends Node2D

var ammo_ar = 30
var ammo_left = 0
var ammo
var isROF = false
var isReload = false
var bulletSpeed = 600
var bulletDamage = 0.8

@onready var gunpoint = $".."
@onready var firespeed = $"../FireSpeed"
@onready var reloadtime = $"../ReloadTimer"
@onready var otherWeapons = [
	$"../hand_pistol",
	$"../hand_shotgun",
	$"../hand_smg"
]

func isGunReady():
	ammo_left = ammo_ar
	print("Assalute Rifle Ammo : ", ammo_left)
	
func isAR():
	get_node(".").visible = true
	for owp in otherWeapons:
		owp.visible = false
	firespeed.wait_time = 0.1
	reloadtime.wait_time = 1.1

func checkAmmo():
	if ammo_left == ammo_ar:
		ammo = ammo_ar
		print("Assalute Rifle ammo remain : ", ammo)
	if ammo_left < ammo_ar:
		ammo = ammo_left
		print("Assalute Rifle ammo remain : ", ammo)
		
func afterProjectileSpawn():
	ammo_left -= 1
	print("Assalute Rifle Ammo : ", ammo_left)
	rate_of_fire()
	
func rate_of_fire():
	firespeed.start()
	isROF = true

func reload_time():
	reloadtime.start()
	isReload = true
	if ammo_left <= 0:
		ammo_left = ammo_ar

func flipingA():
	get_node("AssaluteRifle").flip_v = true
	get_node("AssaluteRifle").position.y = -1

func flipingB():
	get_node("AssaluteRifle").flip_v = false
	get_node("AssaluteRifle").position.y = 1

func _on_fire_speed_timeout():
	isROF = false

func _on_reload_timer_timeout():
	isReload = false
	if ammo_left == ammo_ar:
		print("Assalute Rifle ammo full")
