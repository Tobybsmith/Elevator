extends Area2D

var damage = 10
var kb = 0.1
var weaponOffset = Vector2.ZERO
var player

func attack():
	player = get_tree().get_root().get_node("Root").get_node("Player")
	self.position.x += 64
	get_node("AttackTimer").start()
	pass

func _physics_process(delta):
	var m = get_global_mouse_position()
	var offset = Vector2(m.x - player.position.x, m.y - player.position.y).normalized()
	self.position = offset * 64
	if(offset.x < 0):
		get_node("Sprite").set_flip_h(true)
	else:
		get_node("Sprite").set_flip_h(false)
	look_at(m)

#from timer
func _on_AttackTimer_timeout():
	self.position.x -= 64
	get_tree().get_root().get_node("Root").get_node("Player").canAttack = true
