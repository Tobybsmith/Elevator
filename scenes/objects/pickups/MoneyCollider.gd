extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if(body.name == "Player"):
			body.money += 1
			#emit some particles
			get_parent().queue_free()
