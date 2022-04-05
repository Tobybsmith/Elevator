extends KinematicBody2D

var target_range = 400
var attack_range = 16
var player = null
var direction = 0
var velocity = Vector2()
var speed = 50
var max_speed = 150
var damage = 10
var health = 100
var gravity = 1400

var type = "e"

var w = load("res://scenes/objects/weapons/fists.tscn")
var weapon

var ableToMove = true
var kbTimer 

var m = load("res://scenes/objects/pickups/money.tscn")

signal attacking

func _ready():
	kbTimer = get_node("KnockbackTimer")
	player = get_tree().get_root().get_node("Root").get_node("Player")
	weapon = w.instance()
	self.add_child(weapon)
	connect("attacking", weapon, "attack")

func _physics_process(delta):
	#incredibly simple AI
	if(self.global_position.distance_to(player.global_position) < target_range + 64 and ableToMove):
		shmoove_towards()
	if(self.global_position.distance_to(player.global_position) < attack_range + 64):
		attack_player()
	
	if(velocity.x > max_speed):
		velocity.x = max_speed
	if(velocity.x < -1*max_speed):
		velocity.x = -1*max_speed
	
	velocity.y += gravity * delta
	if(ableToMove):
		velocity += Vector2(speed * direction, 0)
	#change enemy global position when moving
	velocity = move_and_slide(velocity, Vector2.UP)
	
	weapon.global_position = self.global_position + Vector2(direction * 32, 0)
	
	if(health <= 0):
		#maybe have a signal here
		var amount = randi()%4 + 1
		for i in range(amount):
			var mon = m.instance()
			get_parent().add_child(mon)
			#have to use global position here
			mon.global_position = self.get_global_position() + Vector2(randi()%65 + 1, -1*randi()%32 + 1)
		self.queue_free()

func shmoove_towards():
	if(player.global_position.x > self.global_position.x):
		direction = 1
		get_node("Sprite").set_flip_h(false)
	if(player.global_position.x < self.global_position.x):
		direction = -1
		get_node("Sprite").set_flip_h(true)

func attack_player():
	#needs to send the attack signal to the weapon too
	emit_signal("attacking")
	player.attacked(weapon)

func attacked(damage, kb):
	ableToMove = false
	if(kbTimer.is_stopped()):
		kbTimer.start()
	if(not kbTimer.is_stopped()):
		velocity += Vector2(kb * -1 * direction, -kb/5)
	direction = 0
	health -= damage


func _on_KnockbackTimer_timeout():
	ableToMove = true;
