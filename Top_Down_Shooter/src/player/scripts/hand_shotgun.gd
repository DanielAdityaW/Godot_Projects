extends Gun

var shotgun_name = "Shotgun"
var shotgun_bullet_speed = 200
var shotgun_bullet_damage = 0.8
var shotgun_bullet_pattern = [-PI/16, -PI/32, 0, PI/32, PI/16]
var shotgun_fire_speed = 0.35
var shotgun_reload_time = 1.5

func _init():
	super(shotgun_name, shotgun_bullet_speed, shotgun_bullet_damage, shotgun_fire_speed, shotgun_reload_time,shotgun_bullet_pattern)
