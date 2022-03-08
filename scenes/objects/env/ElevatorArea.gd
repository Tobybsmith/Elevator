extends Area2D


var teleport  = false
var t = 120

signal prepare_area

# Called when the node enters the scene tree for the first time.
func _ready():
	#root node
	var n = get_parent().get_parent().get_parent().get_parent()
	connect("prepare_area", n, "_prepare_area")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	t -= 1
	if(teleport and Input.is_action_pressed("interact") and t <= 0):
		emit_signal("prepare_area")


func _on_ElevatorArea_body_entered(body):
	if(body.name == "Player"):
		teleport = true
