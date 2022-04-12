extends Node2D

var damage = 10
var speed = 10
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	global_position += direction * speed

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		body.take_damage(damage)
