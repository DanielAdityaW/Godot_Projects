extends Control

var item_number

var selected_frame_path = "res://assets/item_frame.png"
var unselected_frame_path = "res://assets/unselected_frame.png"

func set_item(image_path, _item_number):
	var image = load(image_path)
	$ItemImage.set_texture(image)
	item_number = _item_number
	$ItemNumber.set_text(str(item_number))

func set_active_frame():
	var image = load(selected_frame_path)
	$ItemFrame.set_texture(image)

func set_inactive_frame():
	var image = load(unselected_frame_path)
	$ItemFrame.set_texture(image)
