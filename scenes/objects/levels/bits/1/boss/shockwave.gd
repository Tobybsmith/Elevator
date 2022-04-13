extends Node2D

var speed = 5
var left
var right
var timer
var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	left = get_node("Left")
	right = get_node("Right")
	timer = get_node("Lifetime")
	timer.start()

func _physics_process(delta):
	left.position -= Vector2(speed, 0)
	right.position += Vector2(speed, 0)

func _on_Lifetime_timeout():
	#die on end of life
	self.queue_free()

func _on_Left_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage)
		body.knockback(Vector2(100, -20))

func _on_Right_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage)
		body.knockback(Vector2(100, -20))
