extends KinematicBody2D

var speed = 350
var MAX_SPEED = 600
var jump_height = 500
var gravity = 1400
var jump = false
var onground = false
var velocity = Vector2()

func _ready():
	pass

func _physics_process(delta):
	velocity.x = 0
	if(Input.is_action_pressed("move_up")):
		if(is_on_floor()):
			velocity.y -= jump_height
	if(Input.is_action_pressed("move_left")):
		velocity.x -= speed
	if(Input.is_action_pressed("move_right")):
		velocity.x += speed
	
	if(velocity.x > MAX_SPEED):
		velocity.x = MAX_SPEED
	if(velocity.x < -1*MAX_SPEED):
		velocity.x = -1*MAX_SPEED
	
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
