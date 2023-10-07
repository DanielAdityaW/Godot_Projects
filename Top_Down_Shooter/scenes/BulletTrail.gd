extends Line2D

var length = 10
var point = Vector2()

func _physics_process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	
	point = $"..".global_position
	add_point(point)
	while get_point_count() >	 length:
		remove_point(0)
	
