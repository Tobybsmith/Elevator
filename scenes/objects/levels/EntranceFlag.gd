extends Area2D

var level1 = load("res://scenes/objects/levels/1.tscn")
var level2 = load("res://scenes/objects/levels/2.tscn")
var l
var enter = false
var canInstance = true

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var levelno = randi() % 2
	var level_array = [level1, level2]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#only make one
	if(enter and canInstance):
		print("Instanced")
		not enter
		canInstance = false
		#need to have a base level (like train) that gets created with instances of little bits of levels
		l = level1.instance()
		get_parent().add_child(l)
		l.set_position(get_parent().get_position() + Vector2(2064, 0))
		

func _on_EntranceFlag_body_entered(body):
	if(body.name == "Player"):
		#spawn in a level randomly (use dexter github train for this)
		#for now just instance level 1
		enter = true
