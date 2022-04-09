extends Area2D

var damage = 10
var kb = 1000
var weaponOffset = Vector2.ZERO
var heldByPlayer = false
var player
var offset

func _ready():
	player = get_tree().get_root().get_node("Root").get_node("Player")
	offset = Vector2(get_global_mouse_position().x - player.position.x, get_global_mouse_position().y - player.position.y).normalized() * -1

func attack():
	get_node("AttackTimer").start()
	pass

func _physics_process(delta):
	if(heldByPlayer):
		self.position = Vector2(player.direction * 64, 0)
		if(player.direction < 0):
			get_node("Sprite").set_flip_v(true)
		if(player.direction > 0):
			get_node("Sprite").set_flip_v(false)

#from timer
func _on_AttackTimer_timeout():
	get_tree().get_root().get_node("Root").get_node("Player").canAttack = true
