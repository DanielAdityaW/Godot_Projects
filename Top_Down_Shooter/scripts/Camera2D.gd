extends Camera2D

@onready var player = $"../Player"
@onready var speed = 5

func _physics_process(delta):
	if player != null:
		#camera position follow player global position
		position = lerp(position, player.global_position, speed * delta)
	else:
		#condition if player is queue_free()
		position
