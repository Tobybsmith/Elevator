extends Area2D


var teleport  = false

signal prepare_area(type)

func _ready():
	#root node
	var n = get_tree().get_root().get_node("Root")
	connect("prepare_area", n, "_prepare_area")

func _physics_process(delta):
	#this is true multiple times for some reason
	if(teleport and Input.is_action_just_pressed("interact")):
		#send to root node
		teleport = false
		#sends to root
		print("Im an elevator")
		emit_signal("prepare_area", 1)
		#remove the ElevatorBody Node
		get_parent().get_parent().remove_child(get_parent())

func _on_ElevatorArea_body_entered(body):
	if(body.name == "Player"):
		teleport = true
