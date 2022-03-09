extends Area2D

var damage = 10
var kb = 0.1
var weaponOffset = Vector2.ZERO

#curently a container object for damage, knockback, a sprite, an animation
#and some other stuff, doesn't do much on it's own, and these get instanced
#to the player when picked up

func attack():
	self.position.x += 64
	get_node("AttackTimer").start()
	pass

#from timer
func _on_AttackTimer_timeout():
	self.position.x -= 64
	get_tree().get_root().get_node("Root").get_node("Player").canAttack = true
