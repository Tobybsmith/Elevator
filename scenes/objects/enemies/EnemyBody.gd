extends KinematicBody2D

#move towards the player and attack if in attack range
#idle if out of target range
#move no attack in in between ranges
var target_range = 400
#this is range outside of the bounds of the enemy collision box (+64)
var attack_range = 16
#problem is that player doesnt exist in this context
#and doesnt until these enemies are instanced
#figure out a way to get the enemy to target the player with
#navigation2D and stuff
var player = null
var direction = 0
var velocity = Vector2()
var speed = 200
var max_speed = 500
var damage = 10
var health = 20

var type = "e"

# Called when the node enters the scene tree for the first time.
func _ready():
	#WILL ALWAYS BE A CHILD OF LEVEL
	player = get_parent().get_parent().get_parent().get_node("Player")

#move_and_slide towards player, when in attack range, do not move and instead make a swiping attack
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(self.global_position.distance_to(player.global_position) < target_range + 64):
		shmoove_towards()
	if(self.global_position.distance_to(player.global_position) < attack_range + 64):
		attack_player()
	
	if(velocity.x > max_speed):
		velocity.x = max_speed
	if(velocity.x < -1*max_speed):
		velocity.x = -1*max_speed
	velocity = Vector2(speed * direction, 0)
	velocity = move_and_slide(velocity, Vector2.UP)
	if(health <= 0):
		self.queue_free()

func shmoove_towards():
	if(player.global_position.x > self.global_position.x):
		direction = 1
	if(player.global_position.x < self.global_position.x):
		direction = -1

func attack_player():
	#re-implement when the weapons have range
	#direction = 0
	player.attacked(damage)

func attacked(damage, kb):
	health -= damage
