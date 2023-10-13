extends Area2D

var SPEED = 65
var BULLET = preload("res://src/projectiles/bullet/scenes/bullet.tscn")
var isAlive = true
var playerHealth = 3
var score = 0
var xp = 0

signal set_selected_weapon(weapon_number)

func _ready():
	get_node("AnimatedSprite2D").play("idle")

func _physics_process(delta):
	if isAlive == true:
		alive(delta)
	if isAlive == false:
		print('game over')

func alive(delta):
	var direction = Vector2(0,0)
	if Input.is_action_pressed("left_side"):
		direction.x = -1  
		get_node("AnimatedSprite2D").flip_h = true
	if Input.is_action_pressed("right_side"):
		direction.x = 1
		get_node("AnimatedSprite2D").flip_h = false
	if Input.is_action_pressed("up_side"):
		direction.y = -1
	if Input.is_action_pressed("down_side"):
		direction.y = 1

	direction = direction.normalized()
	var vel = direction * SPEED

	if vel.x == 0 and vel.y == 0:
		get_node("AnimatedSprite2D").play("idle")
	elif vel.x != 0 or vel.y != 0:
		get_node("AnimatedSprite2D").play("run")

	position += vel * delta

func _on_area_entered(area):
	if area.name == "BulletDetecion":
		playerHealth -= 1
		print("player health :", playerHealth)
		if playerHealth <= 0:
			$Gunpoint.queue_free()
			isAlive = false
			get_node("AnimatedSprite2D").play("death")
			await get_node("AnimatedSprite2D").animation_finished
			self.queue_free()

func add_xp(value):
	xp += value
	print("Player XP : ", xp)

func _on_reload_timer_timeout():
	pass # Replace with function body.
