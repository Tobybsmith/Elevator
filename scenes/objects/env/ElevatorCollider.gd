extends Area2D

#stores the type of destination (combat level, cafeteria, treasure level, shop, etc)
var type
#stores the direction the elevator moves (up, down left, right as a vector)
var direction = Vector2()
#may want different elevator styles as the player moves between areas
var style

var e = load("res://scenes/objects/env/elevatorbody.tscn")
var el

var teleport = false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if(teleport and Input.is_action_pressed("interact")):
		teleport = false
		#move the player to the elevator body
		#have a fade effect to mask this teleportation
		#when player enters elevator doors and presses button
		el = e.instance()
		get_parent().add_child(el)
		el.set_position(Vector2(1000, 1000))
		get_parent().get_parent().get_parent().get_node("Player").position = el.global_position


func _on_ElevatorCollider_body_entered(body):
	if(body.name == "Player"):
		teleport = true
