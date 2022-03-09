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

#will need a middle, left end and right end
#middle should contain the elevator the player came in on but only as a sprite
var end = load("res://scenes/objects/levels/end.tscn")

var l
var levels
var path = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#comes from root
func make_level(type):
	print("make level")
	for i in range(5):
		randomize()
		#this is an array of bit instances that makes up the current level
		path = "res://scenes/objects/levels/bits/" + str(type) + "/" + str(randi()%3 + 1) + ".tscn"
		l = load(path).instance()
		self.add_child(l)
		#each bit is 1024 long, so each bit needs to be placed 1024 away from the next bit to make everything smooth
		l.set_position(Vector2(0 + 1024 * i, 0))
	l = end.instance()
	self.add_child(l)
	l.set_position(Vector2(1024 * 5, 0))
