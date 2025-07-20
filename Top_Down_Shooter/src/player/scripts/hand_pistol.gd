extends Gun

var pistol_name = "Pistol"
var pistol_ammo = 8
var pistol_bullet_speed = 350
var pistol_bullet_damage = 0.8
var pistol_bullet_pattern = [0.0]
var pistol_fire_speed = 0.35
var pistol_reload_time = 1
var weapon_number = 1

func _init():
	super(
		pistol_name, 
		pistol_bullet_speed, 
		pistol_bullet_damage,
		pistol_fire_speed, 
		pistol_reload_time, pistol_ammo, pistol_bullet_pattern)
