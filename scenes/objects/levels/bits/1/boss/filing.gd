extends Node2D

var risingSpeed = 10
var drawerSpeed = 1
var maxHeight = -128
var direction = 1

var topTimer
var drawerTimer
var atTop = false
var drawer
var draw = true

var damage = 10

func _ready():
	topTimer = get_node("HeightTrigger")
	topTimer.start()
	drawerTimer = get_node("EndOfAttack")
	drawerTimer.start()
	drawer = get_node("DrawerArea")

func _physics_process(delta):
	if position.y < 0:
		risingSpeed = 0
		atTop = true
		drawerSpeed = 10
	if abs(drawer.position.x) > 64:
		self.queue_free()
	if not atTop:
		global_position += Vector2(0, -1*risingSpeed)
	
	if atTop:
		drawer.global_position += Vector2(direction*drawerSpeed, 0)

func _on_EndOfAttack_timeout():
	pass

func _on_DrawerArea_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage)
		body.knockback(Vector2(100, -20))

func _on_BodyArea_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage)
		body.knockback(Vector2(100, -20))
