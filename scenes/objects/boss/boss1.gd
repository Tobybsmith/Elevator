extends KinematicBody2D

var direction = Vector2()

signal openDoorOnDeath
var leftDoor

var health = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	leftDoor = get_parent().get_node("LeftDoor")
	connect("openDoorOnDeath", leftDoor, "open")

func _physics_process(delta):
	if(health < 0):
		death()
	

func look_at(body):
	if(body.position.x < position.x):
		#look left
		direction = Vector2(-1, 0)
	if(body.position.x > position.x):
		#look right
		direction = Vector2(1, 0)

func death():
	self.queue_free()
	emit_signal("openDoorOnDeath")

func attacked(damage):
	health -= damage
