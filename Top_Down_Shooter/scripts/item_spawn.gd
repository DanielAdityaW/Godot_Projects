extends Area2D

var score_value = 1

func _on_area_entered(area):
	if area.name == "Player":
		Singleton.add_score(score_value)
		queue_free()
