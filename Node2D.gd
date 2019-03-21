extends Node2D

# class member variables go here, for example:
var maxTime
var currentTime

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func updateCircle(time):
	currentTime = time
	update()
	
func _draw():
	