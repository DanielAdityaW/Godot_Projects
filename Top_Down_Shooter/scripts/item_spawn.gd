extends Area2D

var score_value = 1
var direction = Vector2.ZERO
var xp_drop = 20
var item_speed = 100
var PLAYER

func _on_area_entered(area):
	if area.name == "Player":
		Game.add_exp(xp_drop)
		queue_free()
	if area.name == "ItemArea":
		direction_to_player(area)

func  _process(delta):
	if(PLAYER != null):
		direction = (PLAYER.global_position - global_position).normalized()
	position += item_speed * direction * delta

func direction_to_player(player):
	PLAYER = player
	direction = (player.global_position - global_position).normalized()
