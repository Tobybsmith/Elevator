extends Node2D

var leftend = load("res://scenes/objects/levels/generic/leftend.tscn")
var rightend = load("res://scenes/objects/levels/generic/rightend.tscn")
var middle = load("res://scenes/objects/levels/generic/middle.tscn")

#generation pattern is leftEnd + randomLength + middle + randomLength + rightEnd
#this is just terrible

var l
var levels
var path = ""
var rng = RandomNumberGenerator.new()
var leftLength
var rightLength
const lower = 1
const upper = 1
var diff

func _ready():
	randomize()
	leftLength = rng.randi_range(lower, upper)
	rightLength = rng.randi_range(lower, upper)

#comes from root
func make_level(type, special, leftEl, rightEl, leftElSpecial, rightElSpecial):
	#generating a special level
	print("TYPE: " + str(type) + " SPECIAL: " + str(type) + " LEFTEL: " + str(leftEl) + " LEFTELSPECIAL: " + str(leftElSpecial) + " RIGHEL: " + str(rightEl) + " RIGHELSPECIAL: " + str(rightElSpecial))
	if(special < 0):
		make_special_level(type, special, leftElSpecial, rightElSpecial)
		return
	
	l = leftend.instance()
	self.add_child(l)
	l.get_node("ElevatorBlock").get_node("ElevatorCollider").type = leftEl
	if(leftElSpecial == -1):
		l.get_node("ElevatorBlock").get_node("ElevatorCollider").special = leftElSpecial
		l.get_node("ElevatorBlock").get_node("Sprite").texture = load("res://assets/sprites/elevators/shopEC.png")
	if(leftElSpecial == -3):
		l.get_node("ElevatorBlock").get_node("ElevatorCollider").special = leftElSpecial
		l.get_node("ElevatorBlock").get_node("Sprite").texture = load("res://assets/sprites/elevators/Boss_Elevator.png")
	l.set_position(Vector2(-256 - 128 - 1024 * leftLength, 0))
	for i in range(leftLength):
		randomize()
		path = "res://scenes/objects/levels/bits/" + str(type) + "/" + str(randi()%3 + 1) + ".tscn"
		print(path)
		l = load(path).instance()
		self.add_child(l)
		l.set_position(Vector2(-1024 * leftLength + 1024 * i, 0))
	
	l = middle.instance()
	self.add_child(l)
	
	for i in range(rightLength):
		randomize()
		path = "res://scenes/objects/levels/bits/" + str(type) + "/" + str(randi()%3 + 1) + ".tscn"
		l = load(path).instance()
		self.add_child(l)
		l.set_position(Vector2(256 + 1024 * i, 0))
	l = rightend.instance()
	self.add_child(l)
	l.get_node("ElevatorBlock").get_node("ElevatorCollider").type = rightEl
	if(rightElSpecial == -1):
		l.get_node("ElevatorBlock").get_node("ElevatorCollider").special = rightElSpecial
		l.get_node("ElevatorBlock").get_node("Sprite").texture = load("res://assets/sprites/elevators/shopEC.png")
	if(rightElSpecial == -3):
		l.get_node("ElevatorBlock").get_node("ElevatorCollider").special = rightElSpecial
		l.get_node("ElevatorBlock").get_node("Sprite").texture = load("res://assets/sprites/elevators/Boss_Elevator.png")
	l.set_position(Vector2(256 + 1024 * rightLength, 0))

func make_special_level(type, special, leftElSpecial, rightElSpecial):
	print("MAKING SPECIAL LEVEL: " + str(special))
	if(special == -1):
		#generate the section's shop
		generate_shop(type, leftElSpecial)
	if(special == -2):
		generate_treasure(type, leftElSpecial)
	if(special == -3):
		print("GENERATING BOSS FLOOR...")
		generate_boss(type, leftElSpecial)

func generate_shop(type, leftElSpecial):
	#load the exit elevator (left side)
	l = leftend.instance()
	self.add_child(l)
	l.get_node("ElevatorBlock").get_node("ElevatorCollider").type = type
	l.set_position(Vector2(-256 - 1024, 0))
	#load a space between the elevator and the center
	l = load("res://scenes/objects/levels/bits/" + str(type) + "/special/inter.tscn").instance()
	self.add_child(l)
	l.set_position(Vector2(-1024, 0))
	#load the elevator we just came from
	l = middle.instance()
	self.add_child(l)
	l = load("res://scenes/objects/levels/bits/"+str(type)+"/special/shop.tscn").instance()
	self.add_child(l)
	l.set_position(Vector2(256, 0))

func generate_treasure(type, leftEl):
	pass

func generate_boss(type, leftEl):
	l = leftend.instance();
	l.position = Vector2(-6 * 64 - 1024*2, 0)
	l.get_node("ElevatorBlock").get_node("ElevatorCollider").type = type
	self.add_child(l)
	l = load("res://scenes/objects/levels/bits/"+str(type)+"/boss/boss_floor.tscn").instance()
	l.position = Vector2(-1024, 0)
	self.add_child(l)
	l = middle.instance()
	l.position = Vector2(128, -128)
	self.add_child(l)
	
