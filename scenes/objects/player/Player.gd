extends KinematicBody2D

#movement and physics logic
var speed = 350
var MAX_SPEED = 600
var jump_height = 500
var gravity = 1400
var jump = false
var velocity = Vector2()
#health and iframe logic
var health = 100
var iframes = false
var iframe_counter = 0
var itime = 120
#weapon object
var w = load("res://scenes/objects/weapons/fists.tscn")
var weapon = null
signal attacking
#EVERY KINEMATIC BODY NEEDS ONE TO WORK
var type = "p"

func _ready():
	#load fists into weapon, they are the default weapon choice the player starts with
	pass

func _process(delta):
	#this is the logic to count down and reset the iframe counter and the frames
	if(iframe_counter > 0):
		iframes = true
		iframe_counter -= 1
	if(iframe_counter == 0):
		iframe_counter = 0
		iframes = false

func _physics_process(delta):
	if(weapon == null):
		weapon = w.instance()
		self.add_child(weapon)
		connect("attacking", weapon, "attack")
	
	velocity.x = 0
	if(Input.is_action_pressed("move_up")):
		if(is_on_floor()):
			velocity.y -= jump_height
	if(Input.is_action_pressed("move_left")):
		velocity.x -= speed
	if(Input.is_action_pressed("move_right")):
		velocity.x += speed
	if(Input.is_action_pressed("attack")):
		attack()
	
	if(velocity.x > MAX_SPEED):
		velocity.x = MAX_SPEED
	if(velocity.x < -1*MAX_SPEED):
		velocity.x = -1*MAX_SPEED
	
	velocity.y += gravity * delta
	
	#have the weapon be with the player
	weapon.global_position = self.global_position + Vector2(32, 0)
	
	velocity = move_and_slide(velocity, Vector2.UP)

func attack():
	#detect overlapping bodies with the weapon, if one of them is an enemy, do damage to that enemy
	#enemies also should get knocked back a bit and they should also have little iframes
	var bodies = weapon.get_overlapping_bodies()
	emit_signal("attacking")
	for body in bodies:
		if(body.type == "e"):
			body.attacked(weapon.damage, weapon.kb)

func attacked(damage):
	#if not invincible, attack and become invincible for a bit
	#if invincible, do nothing
	if(not iframes):
		print(health)
		health = health - damage
		iframes = true
		iframe_counter = itime
	if(iframes):
		pass
