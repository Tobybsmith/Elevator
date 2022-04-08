extends Node2D

var door

# Called when the node enters the scene tree for the first time.
func _ready():
	close()
	door = get_node("StaticBody2D/CollisionShape2D")
	print("READY")

func open():
	#disable collision
	get_node("StaticBody2D/CollisionShape2D").set_deferred("disabled", true)
	print("Open The Door")

func close():
	#enable collision
	get_node("StaticBody2D/CollisionShape2D").set_deferred("disabled", false)
	print("Close The Door")
