extends Control

var item_scene = preload("res://src/ui/scenes/Itembar/item.tscn")
# Called when the node enters the scene tree for the first time.
var selected_weapon = 1

var items = [{
	"path" : "res://assets/spritesheet/weapons/pistol.png",
	"number" : 1,
},
{
	"path" : "res://assets/spritesheet/weapons/shotgun.png",
	"number" : 2,
},
{
	"path" : "res://assets/spritesheet/weapons/smg.png",
	"number" : 3,
},
{
	"path" : "res://assets/spritesheet/weapons/assalute_rifle.png",
	"number" : 4,
}]

func _ready():
	load_items()
	change_weapon(selected_weapon)


func load_items():
	for item_data in items:
		var new_item = item_scene.instantiate()
		new_item.set_item(item_data["path"], item_data["number"])
		$Itembar/Grid.add_child(new_item)

func change_weapon(weapon_number):
	var weapons = $Itembar/Grid.get_children()
	for weapon in weapons:
		if(weapon.item_number == weapon_number):
			weapon.set_active_frame()
		else:
			weapon.set_inactive_frame()


func _on_player_set_selected_weapon(weapon_number):
	change_weapon(weapon_number)
