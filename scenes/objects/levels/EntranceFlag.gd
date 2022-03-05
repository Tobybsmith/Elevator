#baselevel is before the elevator entrance,
#you hit the Area2D and it triggers the game to start
#then it instances Levels, which are made of randomly connected level bits
#one floor = one level made of a ton of level bits
#after clearing the floor, there is a new elevator to take upwards
#or maybe sideways, or even downwards

extends Area2D

#could load different types of level with this
#as the player gets higher up the tower
var level = load("res://scenes/objects/levels/level.tscn")
var l
var levels
var enter = false
var canInstance = true


func _physics_process(delta):
	#only make one
	#instances a level, which is built from bits in level.gd
	#this means that levels can be made and instanced into the scene separatly
	if(enter and canInstance):
		print("Instancing")
		not enter
		canInstance = false
		l = level.instance()
		get_parent().add_child(l)
		l.set_position(get_parent().get_position() + Vector2(2064, 0))

func _on_EntranceFlag_body_entered(body):
	if(body.name == "Player"):
		#spawn in a level randomly (use dexter github train for this)
		#for now just instance level 1
		enter = true
