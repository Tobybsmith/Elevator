extends Area2D

var damage = 10
var kb = 1000
var weaponOffset = Vector2.ZERO
var heldByPlayer = false
var player
var offset

var proj = load("res://scenes/objects/weapons/gun_projectile.tscn")
var projectile

func _ready():
	player = get_tree().get_root().get_node("Root").get_node("Player")
	offset = Vector2(get_global_mouse_position().x - player.position.x, get_global_mouse_position().y - player.position.y).normalized() * -1

func attack():
	get_node("AttackTimer").start()
	pass

func _physics_process(delta):
	if(Input.is_action_just_pressed("attack")):
		#offset is direction to the mouse
		#instance a projectile at tip of gun (offset * length of sprite)
		print("Gun attacking")
		projectile = proj.instance()
		self.add_child(projectile)
		projectile.vel = get_global_mouse_position().normalized() * projectile.speed
	if(heldByPlayer):
		self.position = Vector2(player.direction * 64, 0)
		if(player.direction < 0):
			get_node("Sprite").set_flip_v(true)
		if(player.direction > 0):
			get_node("Sprite").set_flip_v(false)

#from timer
func _on_AttackTimer_timeout():
	get_tree().get_root().get_node("Root").get_node("Player").canAttack = true
