extends Node

var score = 0

func get_score():
	return score

func add_score(value):
	score += value
	print("Current score : ", score)

func set_score(value):
	score = value
