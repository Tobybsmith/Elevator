extends Node2D


var leftDoor
var rightDoor
var spawner

signal closeRD
signal openLD


# Called when the node enters the scene tree for the first time.
func _ready():
	leftDoor = get_node("LeftDoor")
	rightDoor = get_node("RightDoor")
	spawner = get_node("BossSpawnerObject")
	#onready, close the left door and open the right door
	connect("closeRD", rightDoor, "close")
	connect("openLD", leftDoor, "open"
	

func summoned():
	print("SUMMONED BOSS")
	emit_signal("closeRD")

func death():
	print("BOSS IS KILLED UWU")
	emit_signal("openLD")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
