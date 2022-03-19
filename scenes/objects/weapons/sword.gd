extends Area2D

var damage = 20
var kb = 0.1
var weaponOffset = Vector2(16, 0)
var weaponRotation = 45
var timer
var cooldown = 0.1
var player
var heldByPlayer = false
var attacking = false
var a = 0

func _ready():
	player = get_tree().get_root().get_node("Root").get_node("Player")
	timer = get_node("AttackTimer")

func _physics_process(delta):
	if(heldByPlayer and not attacking):
		var m = get_global_mouse_position()
		var offset = Vector2(m.x - player.position.x, m.y - player.position.y).normalized() * -1
		self.position = offset * 64 * -1
		if(offset.x < 0):
			get_node("Sprite").set_flip_h(true)
		else:
			get_node("Sprite").set_flip_h(false)
		look_at(m)
		if(attacking):
			a += 0.001
			offset = Vector2(cos(a) * m.x - player.position.x - sin(a) * m.y - player.position.y, sin(a) * m.x - player.position.x + cos(a) * m.y - player.position.y)
			self.position = offset * 64 * -1
			if(offset.x < 0):
				get_node("Sprite").set_flip_h(true)
			else:
				get_node("Sprite").set_flip_h(false)

func attack():
	#this is gonna be annoying
	self.rotation += weaponRotation
	timer.start()
	attacking = true
	pass


#sync this to time of animation.
func _on_AttackTimer_timeout():
	self.rotation -= 45
	attacking = false
	a = 0;
	#change this to separate cooldown
	get_tree().get_root().get_node("Root").get_node("Player").canAttack = true
