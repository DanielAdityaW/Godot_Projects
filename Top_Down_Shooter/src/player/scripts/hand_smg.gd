extends Gun

@export var weapon_number := 3

func _ready():
	gunName = "Smg"
	ammoGun = 25
	bulletSpeed = 400
	bulletDamage = 0.5
	fireSpeed = 0.15
	reloadTime = 1.5
	bulletSpread = [0]
	
	super._ready()
