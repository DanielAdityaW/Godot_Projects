extends Area2D

var score = 0
var new_score

func _on_area_entered(area):
	if area.name == "Player":
		new_score = score + 1
		print(new_score)
		queue_free()
