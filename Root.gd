extends Node2D

#this will manage the instancing of the new terrain when the signal from the 
#elevatorarea is given, and destroys the old terrain and adds new terrain using the 
#level construction code from the baselevel.gd file

#load the level(there is only one that gets destroyed and recreated with each elevator teleport)
var l = load("res://scenes/objects/levels/level.tscn")

var prep = false
var con = false

signal make_level(type)

func _ready():
	pass

func _process(delta):
	pass

#runs once the signal is emit, comes from ElevatorArea.gd
func _prepare_area(type):
	#only prepare the level once
	if(not prep):
		#remove the current node called level
		#then create a new one
		#this code removes the "level" node from the "Root" node
		for i in get_children():
			if(i.name == "level"):
				print("removal")
				self.remove_child(i)
		
		#create a new level node
		var level = l.instance()
		level.name = "level"
		self.add_child(level)
		#sends to level.gd
		connect("make_level", get_node("level"), "make_level")
		#make the level node make a level - will need to pass information like type and length
		emit_signal("make_level", type)
		level.set_global_position(Vector2.ZERO)
		#teleport player back to the level begin
		self.get_node("Player").set_global_position(Vector2(32, -64))
