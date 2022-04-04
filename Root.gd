extends Node2D
#nofilter
#this will manage the instancing of the new terrain when the signal from the 
#elevatorarea is given, and destroys the old terrain and adds new terrain using the 
#level construction code from the baselevel.gd file

#load the level(there is only one that gets destroyed and recreated with each elevator teleport)
var l = load("res://scenes/objects/levels/level.tscn")

var prep = false
var con = false

#determines what level types the elevators can generate
#levels wont have "difficulty", just a style that gets assigned to that floor set
#e.g gen all accounting floors for the next few levels
#or only IT floors
var segment = 1
#max of 3 or 4 maybe
#ends with boss
var flr = 1

#special is a flag to override the default gen, which depends on type
signal make_level(type, special)
signal assign_difficulty(diff)

func _ready():
	pass

func _process(delta):
	pass

#runs once the signal is emit, comes from ElevatorArea.gd
func _prepare_area(type, special):
	print(type)
	if(not prep):
		for i in get_children():
			if(i.name == "level"):
				self.remove_child(i)
		#destinations for left and right elevators in the level
		#when these get randomly assigned, we have a chance to set special high on a special elevator.
		var leftEl = segment
		var rightEl = segment
		var leftElSpecial = 0
		var rightElSpecial = 0
		#interrupts for special gen
		#chance for shop gen
		if(randi() % 7 == 0):
			#gen a special left elevator
			#-1 = shop, -2 = treasure, -3 = healing, -4 = miniboss, -5 = event
			leftElSpecial = -1
		if(randi() % 7 == 0):
			rightElSpecial = -1
		#chance for treasure gen
		var level = l.instance()
		level.name = "level"
		self.add_child(level)
		#sends to level.gd
		connect("make_level", get_node("level"), "make_level")
		emit_signal("make_level", type, special, leftEl, rightEl, leftElSpecial, rightElSpecial)
		level.set_global_position(Vector2.ZERO)
		#teleport player back to the level begin
		self.get_node("Player").set_global_position(Vector2(32, -64))
		#update the floor "chunks"
		flr += 1;
		if(flr == 3):
			flr = 1
			#gen the boss floor
			segment += 1
		segment = min(segment, 3)
