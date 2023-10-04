extends Area2D

var bullet_speed = 500
var direction = Vector2(1,0)
var max_distance = 2000

func _physics_process(delta):
	if position.x > max_distance or position.x < -max_distance:
		queue_free()
	if position.y > max_distance or position.y < -max_distance:
		queue_free()
	
	position += (direction * bullet_speed * delta)
		
func _on_area_entered(area):
	if area.name == "BulletDetecion":
		area.get_parent().damage(1)
		queue_free()
