extends KinematicBody2D

#move towards the player and attack if in attack range
#idle if out of target range
#move no attack in in between ranges
var target_range = 400
var attack_range = 32
#problem is that player doesnt exist in this context
#and doesnt until these enemies are instanced
#figure out a way to get the enemy to target the player with
#navigation2D and stuff
var player = null
var direction = 0
var velocity = Vector2()
var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#move_and_slide towards player, when in attack range, do not move and instead make a swiping attack
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
