extends KinematicBody2D

var direction = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func look_at(body):
	if(body.position.x < position.x):
		#look left
		direction = Vector2(-1, 0)
	if(body.position.x > position.x):
		#look right
		direction = Vector2(1, 0)
