extends Area2D

var damage = 20
var kb = 0.1
var weaponOffset = Vector2(16, 0)
var weaponRotation = 45
var timer
var cooldown = 0.1

#curently a container object for damage, knockback, a sprite, an animation
#as well as special attack behaviour
#all the weapons are modular and just need to be named "name.tscn" to work in the game
func _ready():
	timer = get_node("AttackTimer")

func attack():
	#make the sword swing
	self.rotation = weaponRotation
	#start timer here
	timer.start()
	pass


func _on_AttackTimer_timeout():
	self.rotation = 0
	get_tree().get_root().get_node("Root").get_node("Player").canAttack = true
