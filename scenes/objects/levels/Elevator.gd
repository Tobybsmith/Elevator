extends KinematicBody2D


var entered = false
var done = false
var velocity = Vector2()
var speed = 3
var maxspeed = 10


func _physics_process(delta):
	#once the player hits the trigger, the elevator moves nonstop
	#maybe have a max height
	if(entered and not done):
		done = true
		velocity.y -= speed
		if(velocity.y < -1*maxspeed):
			velocity.y = -1*maxspeed
	#cant use move_and_slide since it stops when colliding with player upwards
	position += velocity

func _on_ElevatorFlag_body_entered(body):
	if(body.name == "Player"):
		entered = true
