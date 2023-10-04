extends Area2D

var exp_point = 1

func _on_area_entered(area):
	if area.name == "Player":
		Game.add_exp(exp_point)
		queue_free()
