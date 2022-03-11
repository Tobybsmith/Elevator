extends Node2D

var leftend = load("res://scenes/objects/levels/leftend.tscn")
var rightend = load("res://scenes/objects/levels/rightend.tscn")
var middle = load("res://scenes/objects/levels/middle.tscn")

#generation pattern is leftEnd + randomLength + middle + randomLength + rightEnd

var l
var levels
var path = ""
var rng = RandomNumberGenerator.new()
var leftLength
var rightLength
const lower = 3
const upper = 5
var diff

func _ready():
	randomize()
	leftLength = rng.randi_range(lower, upper)
	rightLength = rng.randi_range(lower, upper)

#comes from root
func make_level(type, leftEl, rightEl):
	l = leftend.instance()
	self.add_child(l)
	l.get_node("ElevatorBlock").get_node("ElevatorCollider").type = leftEl
	l.set_position(Vector2(-256 - 128 - 1024 * leftLength, 0))
	for i in range(leftLength):
		randomize()
		path = "res://scenes/objects/levels/bits/" + str(type) + "/" + str(randi()%3 + 1) + ".tscn"
		l = load(path).instance()
		self.add_child(l)
		l.set_position(Vector2(- 1024 * leftLength + 1024 * i, 0))
	l = middle.instance()
	self.add_child(l)
	l.set_position(Vector2(64*2, -64*2))
	
	for i in range(rightLength):
		randomize()
		path = "res://scenes/objects/levels/bits/" + str(type) + "/" + str(randi()%3 + 1) + ".tscn"
		l = load(path).instance()
		self.add_child(l)
		l.set_position(Vector2(256 + 1024 * i, 0))
	l = rightend.instance()
	self.add_child(l)
	l.get_node("ElevatorBlock").get_node("ElevatorCollider").type = rightEl
	l.set_position(Vector2(256 + 1024 * rightLength, 0))
