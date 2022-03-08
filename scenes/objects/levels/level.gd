#baselevel is before the elevator entrance,
#you hit the Area2D and it triggers the game to start
#then it instances Levels, which are made of randomly connected level bits
#one floor = one level made of a ton of level bits
#after clearing the floor, there is a new elevator to take upwards
#or maybe sideways, or even downwards

#here we need a way to programmatically make a navigation2D 
#and make sure that enemies can use it
#the alternative is to not do that

extends Node2D

#these are the level bits, will have to load all the bits possible, and change the make_level() function
#to  take in a value to make different level types
var level1 = load("res://scenes/objects/levels/bits/1/1.tscn")
var level2 = load("res://scenes/objects/levels/bits/1/2.tscn")
var level3 = load("res://scenes/objects/levels/bits/1/3.tscn")

var l
var levels

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func make_level():
	#this is an array of possible level bits for the current level
	var level_array = [level1, level2, level3]
	for i in range(5):
		randomize()
		#this is an array of bit instances that makes up the current level
		l = level_array[randi()%3].instance()
		get_parent().add_child(l)
		#each bit is 1024 long, so each bit needs to be placed 1024 away from the next bit to make everything smooth
		l.set_position(Vector2(0 + 1024 * i, 0))
