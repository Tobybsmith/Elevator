extends KinematicBody2D

var direction = Vector2()

signal death
var leftDoor
var floorManager

var health = 1

var state = 1
var attacks = ["Shoot", "Shockwave", "Filing"]

#stores the x locations of potential teleports
var locations = [384, 1024, 1664]
var destination

var teleportTimer
var canTeleport = false
var idleTimer
var notIdle = false

var attack

# Called when the node enters the scene tree for the first time.
func _ready():
	teleportTimer = get_node("TeleportTimer")
	idleTimer = get_node("IdleTimer")
	floorManager = get_parent()
	connect("death", floorManager, "death")

func _physics_process(delta):
	if(health < 0):
		death()
	
	#AI state machine time
	#state 1: teleport to a new location
	#state 2: idle after teleport
	#state 3: target player for attack and randomly select one attack
	#state 4: shoot attack
	#state 5: shockwave attack
	#state 6: filing cabinet attack
	#state 7: idle after attack, prepare to move to 1 or 3 randomly
	if state == 1:
		print("LOOKING FOR TELEPORT")
		#pick a random destination based on the list of available destinations
		destination = locations[randi()%3]
		#teleport after a delay
		teleportTimer.start()
		if canTeleport:
			print('RIDING DIRTY')
			global_position = Vector2(destination, -128)
			state = 2
	elif state == 2:
		print("IDLING")
		#just wait for a hot sec
		idleTimer.start()
		if notIdle:
			state = 3
	elif state == 3:
		print("PICKING ATTACK NOW")
		attack = randi()%3 + 1 #will be 1 2 or 3
		#move to 4 5 or 6
		state = state + attack
		#after some time to do the attack
	elif state == 4:
		#shoot attack
		state = 1
		pass
	elif state == 5:
		#shockwave attack
		state = 1
		pass
	elif state == 6:
		#filing cabinet
		state = 1
		pass

func look_at(body):
	if(body.position.x < position.x):
		#look left
		direction = Vector2(-1, 0)
	if(body.position.x > position.x):
		#look right
		direction = Vector2(1, 0)

func death():
	self.queue_free()
	emit_signal("death")

func attacked(damage):
	health -= damage

#seems unable to reach here, very suss
func _on_TeleportTimer_timeout():
	canTeleport = true
	print("CAN TELEPORT NOW")


func _on_IdleTimer_timeout():
	notIdle = true
