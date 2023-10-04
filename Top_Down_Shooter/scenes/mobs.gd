extends Node2D

@onready var player = $"../player/Player"
var enemy = preload("res://scenes/enemy_1.tscn")

func _ready():
	randomize()

func _on_timer_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	if player != null:
		$"../player/Player/Path2D/PathFollow2D".progress = rng.randi_range(0, 2062)
		var enemySpawn = enemy.instantiate()
		
		enemySpawn.global_position = $"../player/Player/Path2D/PathFollow2D/Marker2D".global_position
		add_child(enemySpawn)

