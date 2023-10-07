extends Area2D

var score_value = 1
var direction = Vector2.ZERO
var xp_drop = 20
var item_speed = 500
var PLAYER
var rng = RandomNumberGenerator.new()
var randomInterpolation = Vector2.ZERO

@onready var idle = $AnimationPlayer

func _ready():
	rng.randomize()
	randomInterpolation = Vector2(position.x + rng.randi_range(-50, 50), position.y + rng.randi_range(-50, 50))

func _on_area_entered(area):
	if area.name == "Player":
		Game.add_xp(xp_drop)
		queue_free()
	if area.name == "ItemArea":
		direction_to_player(area)

func  _physics_process(delta):
	position = lerp(position, randomInterpolation, 2 * delta)
	idle.play("idle")
	
	if(PLAYER != null):
		direction = (PLAYER.global_position - global_position).normalized()
	position += item_speed * direction * delta

func direction_to_player(player):
	PLAYER = player
	direction = (player.global_position - global_position).normalized()
