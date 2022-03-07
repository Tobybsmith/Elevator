extends Node2D

#this will manage the instancing of the new terrain when the signal from the 
#elevatorarea is given, and destroys the old terrain and adds new terrain using the 
#level construction code from the baselevel.gd file

var l = load("res://scenes/objects/levels/level.tscn")

var prep = false
var con = false

signal make_level

func _ready():
	pass

func _process(delta):
	pass

func _prepare_area():
	if(not prep):
		prep = true
		#here needs to be the code to clear this node of terrain
		#there will probably be one child node called "terrain"
		#and then it must create a new child node called "terrain"
		#with new instanced terrain 
		#deletes the current terrain
		var count = self.get_child_count()
		#MINKUS ??? should remove the terrain node
		for i in range(count):
			if(self.get_child(i).name == "level"):
				self.remove_child(self.get_child(i))
		
		#create a new level node
		var level = l.instance()
		level.name = "level"
		self.add_child(level)
		connect("make_level", get_node("level"), "make_level")
		#make the level node make a level
		emit_signal("make_level")
		level.set_global_position(Vector2.ZERO)
		#teleport player back to the level begin
		self.get_node("Player").set_global_position(Vector2(32, -64))
