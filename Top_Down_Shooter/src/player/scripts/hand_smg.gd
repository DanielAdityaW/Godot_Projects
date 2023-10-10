extends Node2D

var ammo_smg = 20
var ammo_left = 0
var ammo
var isROF = false
var isReload = false
var bulletSpeed = 500
var bulletDamage = 0.3

@onready var gunpoint = $".."
@onready var firespeed = $"../FireSpeed"
@onready var reloadtime = $"../ReloadTimer"
@onready var otherWeapons = [
	$"../hand_pistol",
	$"../hand_shotgun",
	$"../hand_assalut_rifle"
]

func isGunReady():
	ammo_left = ammo_smg
	print("SMG Ammo : ", ammo_left)
	
func isSMG():
	get_node(".").visible = true
	for owp in otherWeapons:
		owp.visible = false
	firespeed.wait_time = 0.2
	reloadtime.wait_time = 1.0

func checkAmmo():
	if ammo_left == ammo_smg:
		ammo = ammo_smg
		print("SMG ammo remain : ", ammo)
	if ammo_left < ammo_smg:
		ammo = ammo_left
		print("SMG ammo remain : ", ammo)
		
func afterProjectileSpawn():
	ammo_left -= 1
	print("SMG Ammo : ", ammo_left)
	rate_of_fire()
	
func rate_of_fire():
	firespeed.start()
	isROF = true

func reload_time():
	reloadtime.start()
	isReload = true
	if ammo_left <= 0:
		ammo_left = ammo_smg

func flipingA():
	get_node("Smg").flip_v = true
	get_node("Smg").position.y = -1

func flipingB():
	get_node("Smg").flip_v = false
	get_node("Smg").position.y = 1

func _on_fire_speed_timeout():
	isROF = false

func _on_reload_timer_timeout():
	isReload = false
	if ammo_left == ammo_smg:
		print("SMG ammo full")
