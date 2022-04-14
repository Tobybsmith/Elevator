extends Node2D

var risingSpeed = 3
var drawerSpeed = 1
var maxHeight = -128

var topTimer
var drawerTimer
var atTop = false
var drawer

var damage = 10

func _ready():
	topTimer = get_node("HeightTrigger")
	topTimer.start()
	drawerTimer = get_node("EndOfAttack")
	drawerTimer.start()
	drawer = get_node("DrawerArea")

func _physics_process(delta):
	while not atTop:
		position += Vector2(0, -1*risingSpeed)
	while atTop:
		drawer.position += Vector2(drawerSpeed,0)
	pass


func _on_HeightTrigger_timeout():
	atTop = true


func _on_EndOfAttack_timeout():
	self.queue_free()


func _on_DrawerArea_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage)
		body.knockback(Vector2(100, -20))


func _on_BodyArea_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage)
		body.knockback(Vector2(100, -20))
