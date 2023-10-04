extends Node

var exp = 0

func get_exp():
	return exp

func add_exp(value):
	exp += value
	print("Exp Collected :", exp)

func set_exp(value):
	exp = value
