extends Area2D

#stores the type of destination (combat level, cafeteria, treasure level, shop, etc)
var type
#stores the direction the elevator moves (up, down left, right as a vector)
var direction = Vector2()
#may want different elevator styles as the player moves between areas
var style
#e stores the elevatorbody scene, and el is the node that scene becomes when instanced
var e = load("res://scenes/objects/env/elevatorbody.tscn")
var el
#this teleports the player from the elevator to the level only once
var teleport = false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	#cant do this in _on_ElevatorCollider_body_entered() since we need to check action inputs as well
	if(teleport and Input.is_action_pressed("interact")):
		teleport = false
		#create a new elevatorbody node and add to tree
		el = e.instance()
		get_parent().add_child(el)
		#move the elevator far away
		el.set_position(Vector2(1000, 1000))
		#teleport the player to the elevatorbody
		get_parent().get_parent().get_parent().get_node("Player").position = el.global_position


func _on_ElevatorCollider_body_entered(body):
	if(body.name == "Player"):
		teleport = true
