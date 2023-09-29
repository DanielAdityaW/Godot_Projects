extends CharacterBody2D

var SPEED = 50
var ROTATESPEED = 40
var BULLET = preload("res://scenes/bullet.tscn")

func _ready():
	get_node("AnimatedSprite2D").play("idle")

func _physics_process(delta):
	alive(delta)
	
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

	move_and_collide(vel * delta)
