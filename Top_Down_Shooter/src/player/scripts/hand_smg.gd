extends Gun

var smg_name = "Smg"
var smg_ammo = 25
var smg_bullet_speed = 400
var smg_bullet_damage = 0.5
var smg_bullet_pattern = [0]
var smg_fire_speed = 0.15
var smg_reload_time = 1.5

func _init():
	super(smg_name, smg_bullet_speed, smg_bullet_damage, smg_fire_speed, smg_reload_time, smg_ammo,smg_bullet_pattern)
