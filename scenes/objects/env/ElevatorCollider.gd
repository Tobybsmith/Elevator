extends Area2D

#goal here is, player touches the ElevatorBlock, and is then
#teleported to an elevator interior scene, where it doesnt move, but shakes to allude movement
#then that evevator scene instances a level of the correct type, and the player gets teleported
#to the level elevator entrance
#all this does is teleport the player to the elevator object
#this will have a signal, to do teleportation, and probably nothing else except animation
#things like type, direction, and destination will be handled by the elevator object
#although this will have to change its sprite according to how the elevator behaves

#alternatively, this could have type and direction, and broadcast that to a generic elevator
#lets do this

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
		get_parent().get_parent().get_node("Player").position = el.global_position


func _on_ElevatorCollider_body_entered(body):
	if(body.name == "Player"):
		teleport = true
