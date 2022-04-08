extends Node2D

var boss_scene = load("res://scenes/objects/boss/boss1.tscn")
var boss
var rightDoor

signal lockRightDoor
signal openRightDoor

# Called when the node enters the scene tree for the first time.
func _ready():
	#right door is open by default, closes when the boss is summoned
	rightDoor = get_parent().get_node("RightDoor")
	connect("lockRightDoor", rightDoor, "close")
	connect("openRightDoor", rightDoor, "open")
	emit_signal("openRightDoor")

func _on_BossSpawnerArea_body_entered(body):
	if(body.name == "Player"):
		summon_boss()

func summon_boss():
	#play cutscene maybe, then summon the boss to the BossSpawnerObject then delete the area2d and collider
	play_cutscene()
	emit_signal("lockRightDoor")
	boss = boss_scene.instance()
	boss.position = position
	#boss is a child of boss_level
	get_parent().add_child(boss)
	self.queue_free()
	pass

func play_cutscene():
	print("Playing cutscene")
