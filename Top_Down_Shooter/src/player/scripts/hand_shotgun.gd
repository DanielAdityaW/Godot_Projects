extends Gun

var shotgun_name = "Shotgun"
var shotgun_ammo = 8
var shotgun_bullet_speed = 200
var shotgun_bullet_damage = 0.8
var shotgun_bullet_pattern = [-PI/16, -PI/32, 0, PI/32, PI/16]
var shotgun_fire_speed = 0.65
var shotgun_reload_time = 2
var weapon_number = 2

func _init():
	super(shotgun_name, shotgun_bullet_speed, shotgun_bullet_damage, shotgun_fire_speed, shotgun_reload_time,shotgun_ammo, shotgun_bullet_pattern)
