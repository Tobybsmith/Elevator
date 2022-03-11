extends Area2D

#remember the type of the default startinglevel elevator
var type = 1
var direction = Vector2()
#depends on type
var style
var e = load("res://scenes/objects/env/elevatorbody.tscn")
var el
var teleport = false
var root

func _ready():
	root = get_tree().get_root().get_node("Root")

func _physics_process(delta):
	#if(type != -1):
		#we know the type has been assigned by level.gd and we can change the sprite to match the type
	if(teleport and Input.is_action_just_pressed("interact")):
		for node in get_children():
			if(node.name == "elevatorbody"):
				self.remove_child(node)
		el = e.instance()
		get_parent().add_child(el)
		el.get_node("ElevatorArea").type = type
		el.set_position(Vector2(1000, 1000))
		root.get_node("Player").position = el.global_position

func _on_ElevatorCollider_body_entered(body):
	if(body.name == "Player"):
		teleport = true
