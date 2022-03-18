extends Area2D

var damage = 10
var kb = 0.1
var weaponOffset = Vector2.ZERO
var heldByPlayer = false
var player
var offset

func _ready():
	player = get_tree().get_root().get_node("Root").get_node("Player")
	offset = Vector2(get_global_mouse_position().x - player.position.x, get_global_mouse_position().y - player.position.y).normalized() * -1

func attack():
	self.position += offset * 64
	get_node("AttackTimer").start()
	pass

func _physics_process(delta):
	if(heldByPlayer):
		var m = get_global_mouse_position()
		offset = Vector2(m.x - player.position.x, m.y - player.position.y).normalized() * -1
		self.position = offset * 64 * -1
		if(offset.x < 0):
			get_node("Sprite").set_flip_h(true)
		else:
			get_node("Sprite").set_flip_h(false)
		look_at(m)

#from timer
func _on_AttackTimer_timeout():
	self.position -= offset * 64
	get_tree().get_root().get_node("Root").get_node("Player").canAttack = true
