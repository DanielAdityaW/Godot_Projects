extends CharacterBody2D

var PLAYER 
var SPEED = 20 
var direction = Vector2.ZERO
var enemyHealth = 5
var items = [
	preload("res://src/interactables/items/item-1/scenes/item_1.tscn")
]
var item_count = 1
var drop_chance = 1
var rng = RandomNumberGenerator.new()
var chase = true
var value
@onready var hit_anim = $hit_anim

func _ready():
	PLAYER = get_node("../../player/Player")
	get_node("AnimatedSprite2D").play("idle")
#	enemyHealth += DifficultyConfig.multiplier * DifficultyConfig.enemy_health_multiplier
#	print("Enemy health : ", enemyHealth)

func _physics_process(delta):
	var playerCondition = PLAYER.get("isAlive") if PLAYER != null else false
	if playerCondition == true:
		moving(delta)
	else:
		get_node("AnimatedSprite2D").play("idle")

func moving(delta):
	if chase == true:
		direction = (PLAYER.global_position - global_position).normalized()
		if get_node("AnimatedSprite2D").animation != "die":
			if direction.x > 0 or direction.x < 0:
				get_node("AnimatedSprite2D").play("run")
				if direction.x < 0:
					get_node("AnimatedSprite2D").flip_h = true
				elif direction.x > 0:
					get_node("AnimatedSprite2D").flip_h = false
	else:
		direction = Vector2.ZERO
	move_and_collide(direction * SPEED * delta)

func damage(value):
	enemyHealth -= value
	if enemyHealth <= 0:
		$BulletDetecion.queue_free()
		chase = false
		hit_anim.play("hit_anim_flash")
		get_node("AnimatedSprite2D").play("die")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()
	hit_anim.play("hit_anim_flash")
	
func spawn_item(_position):
	items.shuffle()
	for x in range(item_count):
		var itemSpawn = items.pop_front().instantiate()
		itemSpawn.position = _position
		get_parent().call_deferred("add_child", itemSpawn)

func _on_tree_exiting():
	var spawn_chance = rng.randf()
	if(spawn_chance <= drop_chance):
		spawn_item(position)
