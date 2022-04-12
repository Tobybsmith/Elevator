extends KinematicBody2D

var speed = 350
var MAX_SPEED = 600
var jump_height = 500
var gravity = 1400
var jump = false
var velocity = Vector2()
var health = 100
var iframes = false
var iframe_counter = 0
var itime = 120
var w = null
var weapon = null
signal attacking
var weaponName = ""
#EVERY KINEMATIC BODY NEEDS ONE TO WORK
#MUST CHANGE THIS
var type = "p"
var canAttack = true

var direction = 1

var itemList = Array()
var itemNameList = Array()

#change later
var money = 10

#how should a passive pickup work?

func _ready():
	picked_up("fists")

func _process(delta):
	if(iframe_counter > 0):
		iframes = true
		iframe_counter -= 1
	if(iframe_counter == 0):
		iframe_counter = 0
		iframes = false

#runs once every phyics frame
func _physics_process(delta):
	if(weapon == null and not w == null):
		weapon = w.instance()
		self.add_child(weapon)
		weapon.name = weaponName
		#sends to weapon.tscn script
		connect("attacking", weapon, "attack")
		weapon.heldByPlayer = true
	
	velocity.x = 0
	if(Input.is_action_pressed("move_up")):
		if(is_on_floor()):
			velocity.y -= jump_height
	if(Input.is_action_pressed("move_left")):
		velocity.x -= speed
		direction = -1
		get_node("AnimatedSprite").set_flip_h(true)
	if(Input.is_action_pressed("move_right")):
		velocity.x += speed
		direction = 1
		get_node("AnimatedSprite").set_flip_h(false)
	if(Input.is_action_just_pressed("attack") and canAttack):
		attack()
		print(money)
	
	if(velocity.x > MAX_SPEED):
		velocity.x = MAX_SPEED
	if(velocity.x < -1*MAX_SPEED):
		velocity.x = -1*MAX_SPEED

	velocity.y += gravity * delta

	if(weapon != null):
		weapon.global_position = self.global_position + Vector2(direction * 32, 0)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	#go through weapon list and do effects

func attack():
	canAttack = false
	var bodies = weapon.get_overlapping_bodies()
	emit_signal("attacking")
	for body in bodies:
		#USE GROUPS FOR STUFF LIKE THIS
		if(body.name == "EnemyBody"):
			body.attacked(weapon.damage, weapon.kb)
		if(body.name == "Boss1"):
			#no knockback to bosses
			body.attacked(weapon.damage)

func attacked(weapon):
	if(weapon.get_overlapping_bodies().has(self)):
		if(not iframes):
			print(health)
			health = health - weapon.damage
			iframes = true
			iframe_counter = itime
		if(iframes):
			pass

func take_damage(damage):
	if(not iframes):
			print(health)
			health = health - damage
			iframes = true
			iframe_counter = itime
	if(iframes):
		pass

#need to pass a weapon param to determine what to load
func picked_up(weapon_passed):
	weaponName = weapon_passed
	var path = "res://scenes/objects/weapons/" + weapon_passed + ".tscn"
	w = null
	if(not weapon == null):
		weapon.queue_free()
	weapon = null
	w = load(path)

func picked_up_item(item_passed):
	#very similar to the weapon code
	var path = "res://scenes/objects/passive/" + item_passed + ".tscn"
	var i = load(path)
	var it = i.instance()
	it.name = item_passed
	self.get_node("ItemManager").add_child(it)
	itemList.append(it)
	itemNameList.append(item_passed)
	it.do_effect()
