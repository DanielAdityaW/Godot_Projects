extends Gun

var assault_name = "AssaluteRifle"
var assault_ammo = 500
var assault_bullet_speed = 700
var assault_bullet_damage = 0.7
var assault_bullet_pattern = [0]
var assault_fire_speed = 0.01
var assault_reload_time = 3.5
var weapon_number = 4

func _init():
	super(assault_name, assault_bullet_speed, assault_bullet_damage, assault_fire_speed, assault_reload_time, assault_ammo,assault_bullet_pattern)
