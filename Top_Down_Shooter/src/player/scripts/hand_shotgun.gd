extends Gun

@export var weapon_number := 2

func _ready():
	gunName = "Shotgun"
	ammoGun = 8
	bulletSpeed = 200
	bulletDamage = 0.8
	fireSpeed = 0.65
	reloadTime = 2.0
	bulletSpread = [-PI / 16, -PI / 32, 0.0, PI / 32, PI / 16]
	
	super._ready()
