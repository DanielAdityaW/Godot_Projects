extends Gun

@export var weapon_number := 4

func _ready():
	gunName = "AssaluteRifle"
	ammoGun = 30
	bulletSpeed = 400
	bulletDamage = 0.8
	fireSpeed = 0.15
	reloadTime = 3.5
	bulletSpread = [0]
	
	super._ready()
