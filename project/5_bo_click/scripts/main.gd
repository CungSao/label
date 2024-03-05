extends Node

var point = 0

func add(amount):
	point += amount
	$Point.text = str(point)
