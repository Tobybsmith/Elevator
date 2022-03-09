extends Area2D

#stores the type of destination (combat level, cafeteria, treasure level, shop, etc)
var type = 1
#stores the direction the elevator moves (up, down left, right as a vector)
var direction = Vector2()
#may want different elevator styles as the player moves between areas
var style
#e stores the elevatorbody scene, and el is the node that scene becomes when instanced
var e = load("res://scenes/objects/env/elevatorbody.tscn")
var el
#this teleports the player from the elevator to the level only once
var teleport = false
var root

func _ready():
	#will have to figure out a way to programmatically set the elevator type within some
	#parameters based around what level type the player came from
	#(random destinations but slowly ramp up difficulty)
	root = get_tree().get_root().get_node("Root")

func _physics_process(delta):
	#cant do this in _on_ElevatorCollider_body_entered() since we need to check action inputs as well
	if(teleport and Input.is_action_just_pressed("interact")):
		#remove all current elevators
		for node in get_children():
			if(node.name == "elevatorbody"):
				self.remove_child(node)
		#create a new elevatorbody node and add to tree
		el = e.instance()
		get_parent().add_child(el)
		el.get_node("ElevatorArea").type = type
		#move the elevator far away
		el.set_position(Vector2(1000, 1000))
		#teleport the player to the elevatorbody
		root.get_node("Player").position = el.global_position


func _on_ElevatorCollider_body_entered(body):
	if(body.name == "Player"):
		teleport = true
