extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var base = get_node("EntranceFlag")
	base.connect("body_entered", self, "_on_EntranceFlag_body_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

func _on_EntranceFlag_body_entered():
	print("Inside")
