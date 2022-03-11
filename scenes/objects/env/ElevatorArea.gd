extends Area2D


var teleport  = false
#type comes from the associated ElevatorArea
var type
var root

signal prepare_area(type)

func _ready():
	root = get_tree().get_root().get_node("Root")
	connect("prepare_area", root, "_prepare_area")

func _physics_process(delta):
	if(teleport and Input.is_action_just_pressed("interact")):
		teleport = false
		#sends to root
		emit_signal("prepare_area", type)
		#remove the ElevatorBody Node
		get_parent().get_parent().remove_child(get_parent())

func _on_ElevatorArea_body_entered(body):
	if(body.name == "Player"):
		teleport = true
