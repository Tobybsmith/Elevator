extends KinematicBody2D

var direction = Vector2()

signal death
var leftDoor
var floorManager

var health = 1

var state = 1
var attacks = ["Shoot", "Shockwave", "Filing"]

#stores the x locations of potential teleports
var locations
var destination

var teleportTimer
var canTeleport = false
var idleTimer
var notIdle = false

var attack
var p_scene = load("res://scenes/objects/levels/bits/1/boss/boss_projectile.tscn")
var projectile
var s_scene = load("res://scenes/objects/levels/bits/1/boss/shockwave.tscn")
var shockwave
var f_scene = load("res://scenes/objects/levels/bits/1/boss/filing.tscn")
var filing

# Called when the node enters the scene tree for the first time.
func _ready():
	teleportTimer = get_node("TeleportTimer")
	idleTimer = get_node("IdleTimer")
	floorManager = get_parent()
	#locations = [floorManager.get_node("Teleport1").global_position, floorManager.get_node("Teleport2").global_position, floorManager.get_node("Teleport3").global_position]
	locations = [floorManager.get_node("Teleport2").global_position]
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
		#pick a random destination based on the list of available destinations
		destination = locations[0]
		#teleport after a delay
		if canTeleport:
			canTeleport = false
			global_position = destination
			state = 2
		if(teleportTimer.is_stopped()):
			teleportTimer.start()
	elif state == 2:
		#just wait for a hot sec
		if notIdle:
			notIdle = false
			state = 3
		if idleTimer.is_stopped():
			idleTimer.start()
	elif state == 3:
		attack = 2 #will be 1 2 or 3
		#move to 4 5 or 6
		state = state + attack
		#after some time to do the attack
	elif state == 4:
		#shoot attack
		shoot_projectile()
		state = 1
		pass
	elif state == 5:
		#shockwave attack
		shockwave()
		state = 1
		pass
	elif state == 6:
		#filing cabinet
		filing_attack()
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

func shoot_projectile():
	#direction vector of projectile to shoot just works lol
	var target = get_tree().get_root().get_node("Root").get_node("Player").global_position - global_position
	target = target.normalized()
	projectile = p_scene.instance()
	self.add_child(projectile)
	projectile.direction = target
	return

func shockwave():
	#no need to target, just to determine range
	#need to get position projected onto x axis
	var starting_pos = Vector2(global_position.x, 0)
	shockwave = s_scene.instance()
	self.add_child(shockwave)
	shockwave.global_position = starting_pos
	return

func filing_attack():
	#crashes really hard
	var starting_pos = Vector2(global_position.x, 128)
	filing = f_scene.instance()
	self.add_child(filing)
	filing.global_position = starting_pos
	print("FILING MADE")
	return

#seems unable to reach here, very suss
func _on_TeleportTimer_timeout():
	canTeleport = true


func _on_IdleTimer_timeout():
	notIdle = true
