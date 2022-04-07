extends Area2D

var vel = Vector2()
var speed = 30

func _ready():
	pass


func _physics_process(delta):
	position += vel
