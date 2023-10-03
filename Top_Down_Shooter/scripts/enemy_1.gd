extends CharacterBody2D

var PLAYER 
var SPEED = 20 
var direction = Vector2.ZERO
var enemyHealth = 5
var item = preload("res://scenes/item_spawn.tscn")

func _ready():
	PLAYER = get_node("../player/Player")
	

func _physics_process(delta):
	var playerCondition = PLAYER.get("isAlive") if PLAYER != null else false
	if playerCondition == true:
		moving(delta)
	else:
		get_node("AnimatedSprite2D").play("idle")
	
func moving(delta):
	direction = (PLAYER.global_position - global_position).normalized()
	if direction.x > 0 or direction.x < 0:
		get_node("AnimatedSprite2D").play("run")
		
		if direction.x < 0:
			get_node("AnimatedSprite2D").flip_h = true
		elif direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
	
	move_and_collide(direction * SPEED * delta)
		
func damage(value):
	enemyHealth -= value
	if(enemyHealth <= 0):
		queue_free()

func spawn_item(_position):
	var itemSpawn = item.instantiate()
	itemSpawn.position = _position
	get_parent().call_deferred("add_child", itemSpawn)


func _on_tree_exiting():
	spawn_item(position)
