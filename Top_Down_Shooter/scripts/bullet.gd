extends Area2D

var bullet_speed = 500
var direction = Vector2(1,0)
var max_distance = 2000

#func _ready():
	#var mouse_position = get_local_mouse_position().normalized()
	#direction = mouse_position

func _physics_process(delta):
	position += direction * bullet_speed * delta
	
	if position.x > max_distance or position.x < -max_distance:
		queue_free()
	
	if position.y > max_distance or position.y < -max_distance:
		queue_free()

