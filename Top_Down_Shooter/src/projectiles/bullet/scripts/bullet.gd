extends Area2D

var bullet_speed 
var direction = Vector2.RIGHT
var max_distance = 2000
var damage
var equiped_weapon

func _init(speedValue = 100, damageValue = 1):
	bullet_speed = speedValue
	damage = damageValue
	
func _ready():
	print("bullet speed: ", bullet_speed)
	print("damage: ", damage)

func _physics_process(delta):
	if position.x > max_distance or position.x < -max_distance:
		queue_free()
	if position.y > max_distance or position.y < -max_distance:
		queue_free()
		
	position += (direction * bullet_speed * delta)
	
func _on_area_entered(area):
	if area.name == "BulletDetecion":
		area.get_parent().damage(damage)
		queue_free()
