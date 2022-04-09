extends Area2D

var damage = 20
var kb = 1500
var weaponOffset = Vector2(16, 0)
var weaponRotation = 45
var timer
var cooldown = 0.1
var player
var heldByPlayer = false
var attacking = false
var a = 0

var coffee = false

func _ready():
	player = get_tree().get_root().get_node("Root").get_node("Player")
	timer = get_node("AttackTimer")

func _physics_process(delta):
	if(heldByPlayer):
		self.position = Vector2(player.direction * 64, 0)
		if(player.direction < 0):
			get_node("Sprite").set_flip_v(true)
		if(player.direction > 0):
			get_node("Sprite").set_flip_v(false)

func attack():
	if(player.itemNameList.has("coffee")):
		damage = 15
	timer.start()
	attacking = true
	pass


#sync this to time of animation.
func _on_AttackTimer_timeout():
	attacking = false
	#change this to separate cooldown
	get_tree().get_root().get_node("Root").get_node("Player").canAttack = true
