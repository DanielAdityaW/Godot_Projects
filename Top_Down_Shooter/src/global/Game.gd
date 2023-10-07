extends Node

var xp = 0

func get_xp():
	return xp

func add_xp(value):
	xp += value
	print("Exp Collected :", xp)

func set_xp(value):
	xp = value
