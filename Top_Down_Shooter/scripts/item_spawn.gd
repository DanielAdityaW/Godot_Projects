extends Area2D

var score_value = 1
var direction = Vector2.ZERO
var xp_drop = 20
var item_speed = 100

func _on_area_entered(area):
	if area.name == "Player":
		Singleton.add_score(score_value)
		area.add_xp(xp_drop)
		queue_free()

func  _process(delta):
	position += item_speed * direction * delta

func direction_to_player(player):
	direction = (player.global_position - global_position).normalized()
