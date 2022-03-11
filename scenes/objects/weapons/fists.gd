extends Area2D

var damage = 10
var kb = 0.1
var weaponOffset = Vector2.ZERO

func attack():
	self.position.x += 64
	get_node("AttackTimer").start()
	pass

#from timer
func _on_AttackTimer_timeout():
	self.position.x -= 64
	get_tree().get_root().get_node("Root").get_node("Player").canAttack = true
