extends Gun

@export var weapon_number := 1

func _ready():
	gunName = "Pistol"
	ammoGun = 8
	bulletSpeed = 350
	bulletDamage = 0.8
	fireSpeed = 0.35
	reloadTime = 1.0
	bulletSpread = [0]
	
	super._ready()
